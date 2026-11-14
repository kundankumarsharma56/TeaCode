import { z } from 'zod';

// Client-side checks are for UX only; the backend validates everything again.
export const emailSchema = z.string().trim().min(1, 'Email is required').max(254).email('Enter a valid email address');

// Upper bound protects the password hasher from oversized input.
export const passwordSchema = z
  .string()
  .min(10, 'Use at least 10 characters')
  .max(128, 'Use at most 128 characters');

export const loginSchema = z.object({
  email: emailSchema,
  password: z.string().min(1, 'Password is required').max(128),
});

export const registerSchema = z
  .object({
    username: z.string().trim().regex(/^[A-Za-z0-9_]{3,30}$/, '3–30 characters: letters, numbers, underscore'),
    email: emailSchema,
    password: passwordSchema,
    confirmPassword: z.string(),
    acceptPolicies: z.literal(true, { message: 'You must accept the Terms and Privacy Policy' }),
  })
  .refine((v) => v.password === v.confirmPassword, { path: ['confirmPassword'], message: 'Passwords do not match' });

export const forgotSchema = z.object({ email: emailSchema });

export const resetSchema = z
  .object({ password: passwordSchema, confirmPassword: z.string() })
  .refine((v) => v.password === v.confirmPassword, { path: ['confirmPassword'], message: 'Passwords do not match' });
