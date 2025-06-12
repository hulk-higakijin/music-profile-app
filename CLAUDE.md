# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a T3 Stack application (Next.js, TypeScript, tRPC, Prisma, NextAuth, Tailwind CSS) for a music profile app. The project uses:
- **Next.js 15** with App Router
- **tRPC** for type-safe API endpoints
- **Prisma** ORM with PostgreSQL
- **NextAuth.js** for authentication (Discord provider configured)
- **Tailwind CSS** for styling
- **Biome** for linting and formatting
- **pnpm** as the package manager

## Development Commands

```bash
# Start development server
pnpm dev

# Database operations
./start-database.sh       # Start PostgreSQL in Docker/Podman
pnpm db:push             # Push schema changes to database
pnpm db:generate         # Generate Prisma migrations
pnpm db:migrate          # Apply migrations
pnpm db:studio           # Open Prisma Studio GUI

# Code quality
pnpm check              # Run Biome linter/formatter
pnpm check:write        # Fix linting/formatting issues
pnpm typecheck          # Run TypeScript type checking

# Build and preview
pnpm build              # Build for production
pnpm preview            # Build and start production server
```

## Architecture

### File Structure
- `/src/app/` - Next.js App Router pages and layouts
- `/src/server/` - Backend code including tRPC routers and Prisma client
  - `/api/routers/` - tRPC router definitions
  - `/auth/` - NextAuth.js configuration
  - `/db.ts` - Prisma client instance
- `/src/trpc/` - tRPC client configuration
- `/prisma/` - Database schema and migrations

### Key Patterns
1. **tRPC Router Pattern**: All API routes are defined in `/src/server/api/routers/` and imported into `/src/server/api/root.ts`
2. **Server Components**: Use `~/trpc/server` for server-side tRPC calls
3. **Client Components**: Use `~/trpc/react` hooks for client-side tRPC calls
4. **Database Access**: Always use the Prisma client from `~/server/db`
5. **Environment Variables**: Validated through `/src/env.js` using zod schemas

### Authentication
NextAuth.js is configured with Discord as the provider. Session data is stored in the database using Prisma adapter.

## Environment Setup

Required environment variables:
- `DATABASE_URL` - PostgreSQL connection string
- `AUTH_SECRET` - NextAuth secret (generate with `npx auth secret`)
- `AUTH_DISCORD_ID` - Discord OAuth app ID
- `AUTH_DISCORD_SECRET` - Discord OAuth app secret

Copy `.env.example` to `.env` and fill in the values.

## Common Development Tasks

### Adding a new tRPC route
1. Create a new router file in `/src/server/api/routers/`
2. Import and add it to `appRouter` in `/src/server/api/root.ts`
3. Use the router in components via tRPC hooks

### Running tests
Currently no test runner is configured. Consider adding Vitest or Jest if tests are needed.