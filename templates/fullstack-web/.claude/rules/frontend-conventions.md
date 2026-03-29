---
globs: ["src/components/**", "src/pages/**", "src/hooks/**"]
---

# Frontend Conventions

- Components are functional with hooks (no class components)
- Co-locate component tests: `ComponentName.test.tsx` next to `ComponentName.tsx`
- Custom hooks in `src/hooks/` with `use` prefix
- Shared types in `src/types/`
- No inline styles — use CSS modules or Tailwind
- Accessibility: all interactive elements must have appropriate ARIA attributes
