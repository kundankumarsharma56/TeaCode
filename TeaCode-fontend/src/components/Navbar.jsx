import { useState } from 'react';
import {
  AppBar, Toolbar, Box, Button, IconButton, Drawer, List, ListItem, ListItemButton,
  ListItemText, Divider, useMediaQuery, Container,
} from '@mui/material';
import { useTheme } from '@mui/material/styles';
import MenuIcon from '@mui/icons-material/Menu';
import CloseIcon from '@mui/icons-material/Close';
import { NavLink, useNavigate } from 'react-router-dom';
import Brand from './Brand.jsx';
import UserAvatar from './UserAvatar.jsx';
import { useAuth } from '../hooks/useAuth.js';
import { useNotify } from '../hooks/useNotify.js';

const CENTER_LINKS = [
  { label: 'Home', to: '/', end: true },
  { label: 'Problem', to: '/problems' },
  ...(import.meta.env.VITE_TERMINAL_ENABLED === 'false' ? [] : [{ label: 'Terminal', to: '/terminal' }]),
  { label: 'About', to: '/about' },
];

export default function Navbar() {
  const theme = useTheme();
  const isDesktop = useMediaQuery(theme.breakpoints.up('md'));
  const [open, setOpen] = useState(false);
  const { user, logout } = useAuth();
  const notify = useNotify();
  const navigate = useNavigate();

  const handleLogout = async () => {
    setOpen(false);
    try {
      await logout();
      navigate('/');
    } catch {
      notify('Could not log out. Please try again.', 'error');
    }
  };

  const activeSx = {
    fontWeight: 600,
    minHeight: 40,
    color: 'text.secondary',
    '&:hover': { color: 'text.primary', bgcolor: 'action.hover' },
    '&.active': { color: 'primary.main', boxShadow: (t) => `inset 0 -2px 0 ${t.palette.primary.main}`, borderRadius: 0 },
  };

  const visibleCenterLinks = user ? CENTER_LINKS.filter((link) => link.label !== 'Home') : CENTER_LINKS;

  const authLinks = user
    ? [
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Practice History', to: '/submissions' },
        { label: 'Profile', to: '/profile' },
      ]
    : [];

  return (
    <AppBar position="sticky" color="inherit" elevation={0} sx={{ borderBottom: 1, borderColor: 'divider', bgcolor: (t) => (t.palette.mode === 'dark' ? 'rgba(11,11,12,.88)' : 'rgba(255,255,255,.88)'), backdropFilter: 'saturate(180%) blur(12px)' }}>
      <Container maxWidth="lg" disableGutters sx={{ px: { xs: 2, md: 3 } }}>
        <Toolbar disableGutters sx={{ gap: 2, minHeight: 64 }}>
          <Brand />

          {isDesktop ? (
            <>
              <Box component="nav" aria-label="Primary" sx={{ flex: 1, display: 'flex', justifyContent: 'center', gap: 1 }}>
                {visibleCenterLinks.map((l) => (
                  <Button key={l.to} component={NavLink} to={l.to} end={l.end} color="inherit" sx={activeSx}>
                    {l.label}
                  </Button>
                ))}
              </Box>
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                {user ? (
                  <>
                    {authLinks.map((l) => (
                      <Button key={l.to} component={NavLink} to={l.to} color="inherit" sx={activeSx}>
                        {l.label}
                      </Button>
                    ))}
                    <UserAvatar user={user} />
                    <Button variant="outlined" color="inherit" onClick={handleLogout} sx={{ fontWeight: 600, borderRadius: 1.5, borderColor: 'divider', '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } }}>Logout</Button>
                  </>
                ) : (
                  <>
                    <Button component={NavLink} to="/login" color="inherit" sx={{ fontWeight: 600 }}>Log in</Button>
                    <Button component={NavLink} to="/register" variant="contained" sx={{ fontWeight: 700, borderRadius: 1.5, boxShadow: 'none' }}>Sign up</Button>
                  </>
                )}
              </Box>
            </>
          ) : (
            <Box sx={{ ml: 'auto', display: 'flex', alignItems: 'center', gap: 0.5 }}>
              <IconButton aria-label="Open navigation menu" aria-expanded={open} aria-controls="mobile-nav" onClick={() => setOpen(true)} color="inherit">
                <MenuIcon />
              </IconButton>
            </Box>
          )}
        </Toolbar>
      </Container>

      <Drawer anchor="right" open={open && !isDesktop} onClose={() => setOpen(false)} slotProps={{ paper: { id: 'mobile-nav', sx: { width: 280, bgcolor: 'background.default', backgroundImage: 'none', borderLeft: 1, borderColor: 'divider' } } }}>
        <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', p: 2 }}>
          <Brand variant="navbar" />
          <IconButton aria-label="Close navigation menu" onClick={() => setOpen(false)}><CloseIcon /></IconButton>
        </Box>
        <Divider />
        <List component="nav" aria-label="Mobile">
          {[...visibleCenterLinks, ...authLinks].map((l) => (
            <ListItem key={l.to} disablePadding>
              <ListItemButton component={NavLink} to={l.to} end={l.end} onClick={() => setOpen(false)} sx={{ minHeight: 48, fontWeight: 600, '&.active': { color: 'primary.main', bgcolor: 'action.selected' } }}>
                <ListItemText primary={l.label} />
              </ListItemButton>
            </ListItem>
          ))}
          <Divider sx={{ my: 1 }} />
          {user ? (
            <ListItem disablePadding>
              <ListItemButton onClick={handleLogout}><ListItemText primary="Logout" /></ListItemButton>
            </ListItem>
          ) : (
            <>
              <ListItem disablePadding>
                <ListItemButton component={NavLink} to="/login" onClick={() => setOpen(false)}><ListItemText primary="Log in" /></ListItemButton>
              </ListItem>
              <ListItem disablePadding>
                <ListItemButton component={NavLink} to="/register" onClick={() => setOpen(false)}><ListItemText primary="Sign up" /></ListItemButton>
              </ListItem>
            </>
          )}
        </List>
      </Drawer>
    </AppBar>
  );
}
