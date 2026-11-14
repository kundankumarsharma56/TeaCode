import { Component } from 'react';
import { Box, Button, Container, Typography } from '@mui/material';

export default class ErrorBoundary extends Component {
  state = { failed: false };

  static getDerivedStateFromError() {
    return { failed: true };
  }

  componentDidCatch(error) {
    // Diagnostics stay in the browser console; nothing sensitive is rendered.
    console.error('Unhandled UI error', error);
  }

  render() {
    if (!this.state.failed) return this.props.children;
    return (
      <Container maxWidth="sm" sx={{ py: 12, textAlign: 'center' }} role="alert">
        <Typography variant="h4" component="h1" gutterBottom>Something went wrong</Typography>
        <Typography color="text.secondary" sx={{ mb: 3 }}>
          An unexpected error occurred. Reloading the page usually fixes it.
        </Typography>
        <Box>
          <Button variant="contained" onClick={() => window.location.assign('/')}>Back to home</Button>
        </Box>
      </Container>
    );
  }
}
