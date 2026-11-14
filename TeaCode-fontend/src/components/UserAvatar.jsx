import { Avatar } from '@mui/material';

/** Shows the user's active avatar (custom upload or provider image), falling back to their initial. */
export default function UserAvatar({ user, size = 32, ...rest }) {
  const name = user?.username || user?.name || '?';
  return (
    <Avatar src={user?.avatarUrl || undefined} alt="" sx={{ width: size, height: size, fontSize: size * 0.45, bgcolor: 'primary.main', color: 'primary.contrastText' }} {...rest}>
      {name.charAt(0).toUpperCase()}
    </Avatar>
  );
}
