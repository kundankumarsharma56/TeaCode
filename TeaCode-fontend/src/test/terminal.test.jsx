import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

class MockWebSocket {
  static OPEN = 1;
  static CLOSING = 2;
  static CLOSED = 3;
  static instances = [];
  constructor(url) { this.url = url; this.readyState = 0; this.sent = []; MockWebSocket.instances.push(this); queueMicrotask(() => { this.readyState = 1; this.onopen?.(); }); }
  send(raw) {
    const message = JSON.parse(raw); this.sent.push(message);
    if (message.type === 'auth') queueMicrotask(() => this.onmessage?.({ data: JSON.stringify({ type: 'authenticated', language: 'python' }) }));
    if (message.type === 'start') queueMicrotask(() => this.onmessage?.({ data: JSON.stringify({ type: 'status', state: 'running' }) }));
    if (message.type === 'stop') queueMicrotask(() => this.onmessage?.({ data: JSON.stringify({ type: 'exit', state: 'stopped' }) }));
  }
  emit(message) { this.onmessage?.({ data: JSON.stringify(message) }); }
  close() { this.readyState = MockWebSocket.CLOSED; this.onclose?.(); }
}

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));
vi.mock('../features/workspace/monacoSetup.js', () => ({}));
vi.mock('@monaco-editor/react', () => ({
  default: ({ value, onChange, language }) => (
    <textarea aria-label="Code editor" data-language={language} value={value} onChange={(e) => onChange(e.target.value)} />
  ),
}));

const LANGS = [{ key: 'python', name: 'Python 3' }, { key: 'java', name: 'Java' }, { key: 'sql', name: 'SQL (MySQL)' }];

function setup({ user = { username: 'ada' }, job = { state: 'COMPLETED', status: 'ACCEPTED', stdout: 'hi\n', executionTimeMs: 12, memoryKb: 900 }, postError } = {}) {
  api.get.mockImplementation((path) => {
    if (path === '/auth/me') return user ? Promise.resolve({ data: user }) : Promise.reject({ response: { status: 401 } });
    if (path === '/terminal/languages') return Promise.resolve({ data: LANGS });
    if (path.startsWith('/submissions/jobs/')) return Promise.resolve({ data: job });
    return Promise.reject(new Error(`unexpected ${path}`));
  });
  if (postError) api.post.mockRejectedValue(postError);
  else api.post.mockImplementation((path) => path === '/terminal/sessions'
    ? Promise.resolve({ data: { sessionId: 'session-123456789012345678901234', token: 'opaque-session-token' } })
    : Promise.resolve({ data: { jobId: 'job-1' } }));
}


async function waitForSocket() {
  for (let i = 0; i < 30; i += 1) {
    if (MockWebSocket.instances.length) return MockWebSocket.instances[0];
    await new Promise((resolve) => setTimeout(resolve, 0));
  }
  throw new Error('WebSocket was not created');
}

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
  MockWebSocket.instances = [];
  vi.stubGlobal('WebSocket', MockWebSocket);
});

describe('terminal', () => {
  it('is reachable directly and offers only backend languages', async () => {
    setup();
    renderApp('/terminal');
    expect(await screen.findByRole('heading', { name: 'Online Compiler' })).toBeInTheDocument();
    await userEvent.click(await screen.findByRole('combobox', { name: 'Language' }));
    expect(await screen.findByRole('option', { name: 'Java' })).toBeInTheDocument();
    expect(screen.queryByRole('option', { name: 'C++' })).not.toBeInTheDocument();
  });

  it('opens an interactive session and sends Enter input to the running process', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    expect(api.post).toHaveBeenCalledWith('/terminal/sessions', { language: 'python' });
    const socket = await waitForSocket();
    socket.emit({ type: 'output', stream: 'stdout', data: 'Enter your name: ' });
    socket.emit({ type: 'status', state: 'waiting' });
    const input = await screen.findByLabelText('Terminal input');
    await userEvent.type(input, 'Rahul{Enter}');
    expect(socket.sent).toContainEqual({ type: 'input', data: 'Rahul\n' });
    socket.emit({ type: 'output', stream: 'stdout', data: 'Enter your age: ' });
    await userEvent.type(await screen.findByLabelText('Terminal input'), '21{Enter}');
    expect(socket.sent).toContainEqual({ type: 'input', data: '21\n' });
    expect(await screen.findByText(/Enter your name:/)).toBeInTheDocument();
    expect(screen.getByLabelText('Terminal input')).toHaveValue('');
  });

  it('allows anonymous users to run code without sign-in or email verification', async () => {
    setup({ user: null });
    renderApp('/terminal');
    const run = await screen.findByRole('button', { name: 'Run' });
    expect(run).toBeEnabled();
    await userEvent.click(run);
    expect(api.post).toHaveBeenCalledWith('/terminal/sessions', expect.objectContaining({ language: 'python' }));
    expect(screen.queryByText(/protects the shared execution quota/)).not.toBeInTheDocument();
  });

  it('shows an execution-service failure instead of fabricating output', async () => {
    setup({ postError: { response: { status: 503, data: { message: 'runner unavailable' } } } });
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    expect(await screen.findByText(/runner unavailable/)).toBeInTheDocument();
    // The source must never be silently sent to the one-shot third-party compiler instead.
    expect(api.post).not.toHaveBeenCalledWith('/terminal/run', expect.anything());
    expect(screen.getAllByText('Error').length).toBeGreaterThan(0);
  });

  it('loads the language list from the terminal endpoint, not the judging one', async () => {
    setup();
    renderApp('/terminal');
    await screen.findByRole('heading', { name: 'Online Compiler' });
    const paths = api.get.mock.calls.map(([path]) => path);
    expect(paths).toContain('/terminal/languages');
    expect(paths).not.toContain('/execution/languages');
  });

  it('reports a compilation failure separately from a runtime failure, with the exit status', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    let socket = await waitForSocket();
    socket.emit({ type: 'status', state: 'compiling' });
    expect(await screen.findAllByText('Compiling')).not.toHaveLength(0);
    socket.emit({ type: 'output', stream: 'stderr', data: 'main.c:1:1: error: expected declaration\n' });
    socket.emit({ type: 'exit', state: 'error', phase: 'compile', exitCode: 1 });
    expect(await screen.findByText(/Compilation failed with exit code 1/)).toBeInTheDocument();
    expect(screen.getAllByText('Compilation error').length).toBeGreaterThan(0);
    expect(screen.getByText(/expected declaration/)).toBeInTheDocument();
    socket.close();

    MockWebSocket.instances = [];
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    socket = await waitForSocket();
    socket.emit({ type: 'exit', state: 'error', phase: 'run', exitCode: 3 });
    expect(await screen.findByText(/Process finished with exit code 3/)).toBeInTheDocument();
    expect(screen.queryByText(/Compilation failed/)).not.toBeInTheDocument();
  });

  it('reports the memory limit and a busy runner as what they are', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    const socket = await waitForSocket();
    socket.emit({ type: 'exit', state: 'memory_limit', exitCode: 137, message: 'The program was killed, most likely because it used more than 256 MB of memory.' });
    expect(await screen.findByText(/used more than 256 MB/)).toBeInTheDocument();
    expect(screen.getAllByText('Memory limit').length).toBeGreaterThan(0);
  });

  it('Ctrl+D sends end-of-input to the running program', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    const socket = await waitForSocket();
    socket.emit({ type: 'status', state: 'waiting' });
    const input = await screen.findByLabelText('Terminal input');
    await userEvent.type(input, '{Control>}d{/Control}');
    expect(socket.sent).toContainEqual({ type: 'eof' });
  });

  it('shows the real inline terminal input while a process is running', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    const socket = await waitForSocket();
    socket.emit({ type: 'status', state: 'running' });
    expect(await screen.findByLabelText('Terminal input')).toBeInTheDocument();
    expect(screen.queryByLabelText('Standard input (optional)')).not.toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Stop execution' })).toBeEnabled();
  });

  it('explains a 403 as a refused request, not as a program or credential error', async () => {
    setup({ postError: { response: { status: 403, data: '' } } });
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    expect(await screen.findByText(/refused this request \(HTTP 403\)/)).toBeInTheDocument();
    expect(screen.queryByText(/Request failed with status code/)).not.toBeInTheDocument();
  });

  it('reports a lost connection while a program is running', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    const socket = await waitForSocket();
    socket.emit({ type: 'status', state: 'running' });
    socket.close();
    expect(await screen.findByText(/connection to the execution service was lost/)).toBeInTheDocument();
    expect(screen.getAllByText('Disconnected').length).toBeGreaterThan(0);
  });

  it('does not report a lost connection after the program exits normally', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    const socket = await waitForSocket();
    socket.emit({ type: 'status', state: 'running' });
    socket.emit({ type: 'exit', state: 'finished', exitCode: 0 });
    socket.close();
    expect(await screen.findByText(/Process finished with exit code 0/)).toBeInTheDocument();
    expect(screen.queryByText(/connection to the execution service was lost/)).not.toBeInTheDocument();
  });

});

describe('compiler usability', () => {
  const MANY = [
    { key: 'java', name: 'Java', version: 'JDK 21' }, { key: 'python', name: 'Python 3', version: '3.14' },
    { key: 'rust', name: 'Rust', version: '1.94' }, { key: 'go', name: 'Go', version: '1.26' },
  ];

  it('filters languages by typing and keeps each language\'s code when switching', async () => {
    setup();
    api.get.mockImplementation((path) => {
      if (path === '/auth/me') return Promise.resolve({ data: { username: 'ada' } });
      if (path === '/terminal/languages') return Promise.resolve({ data: MANY });
      return Promise.reject(new Error(`unexpected ${path}`));
    });
    renderApp('/terminal');
    const editor = await screen.findByLabelText('Code editor');
    await userEvent.clear(editor);
    await userEvent.type(editor, 'MY-JAVA-CODE');
    const box = screen.getByRole('combobox', { name: 'Language' });
    await userEvent.click(box);
    await userEvent.clear(box);
    await userEvent.type(box, 'rus');
    expect(screen.queryByRole('option', { name: /Java/ })).not.toBeInTheDocument();
    await userEvent.click(await screen.findByRole('option', { name: /Rust/ }));
    expect(screen.getByLabelText('Code editor').value).toContain('fn main');
    await userEvent.click(screen.getByRole('combobox', { name: 'Language' }));
    await userEvent.clear(screen.getByRole('combobox', { name: 'Language' }));
    await userEvent.type(screen.getByRole('combobox', { name: 'Language' }), 'java');
    await userEvent.click(await screen.findByRole('option', { name: /Java/ }));
    expect(screen.getByLabelText('Code editor')).toHaveValue('MY-JAVA-CODE');
  });

  it('keeps the SQL one-shot path and shows its quota error', async () => {
    setup({ postError: { response: { status: 503, data: { code: 'EXECUTION_QUOTA_EXCEEDED' } } } });
    renderApp('/terminal');
    const languageBox = await screen.findByRole('combobox', { name: 'Language' });
    await userEvent.click(languageBox);
    await userEvent.click(await screen.findByRole('option', { name: /SQL \(MySQL\)/ }));
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    expect(await screen.findByRole('alert')).toHaveTextContent(/quota is used up/);
  });
});


describe('terminal input focus', () => {
  it('puts the cursor on the input line as soon as the program is running, even if the runner never reports waiting', async () => {
    setup();
    renderApp('/terminal');
    await userEvent.click(await screen.findByRole('button', { name: 'Run' }));
    const socket = await waitForSocket();
    socket.emit({ type: 'status', state: 'running' });
    const input = await screen.findByLabelText('Terminal input');
    await waitFor(() => expect(input).toHaveFocus());
  });
});