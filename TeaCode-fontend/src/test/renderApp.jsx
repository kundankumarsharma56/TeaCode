import { render } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import App from '../app/App.jsx';
import { ColorModeProvider } from '../context/ColorModeContext.jsx';
import { AuthProvider } from '../context/AuthContext.jsx';
import { NotifyProvider } from '../context/NotifyContext.jsx';

export function renderApp(route = '/') {
  return render(
    <ColorModeProvider>
      <NotifyProvider>
        <MemoryRouter initialEntries={[route]}>
          <AuthProvider>
            <App />
          </AuthProvider>
        </MemoryRouter>
      </NotifyProvider>
    </ColorModeProvider>,
  );
}
