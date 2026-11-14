import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import App from './app/App.jsx';
import ErrorBoundary from './components/ErrorBoundary.jsx';
import { ColorModeProvider } from './context/ColorModeContext.jsx';
import { AuthProvider } from './context/AuthContext.jsx';
import { NotifyProvider } from './context/NotifyContext.jsx';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <ColorModeProvider>
      <ErrorBoundary>
        <NotifyProvider>
          <BrowserRouter>
            <AuthProvider>
              <App />
            </AuthProvider>
          </BrowserRouter>
        </NotifyProvider>
      </ErrorBoundary>
    </ColorModeProvider>
  </React.StrictMode>,
);
