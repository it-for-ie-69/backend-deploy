# Base image of nodejs with alpine linux
FROM node:24-alpine3.21 AS base

# Install dependencies
RUN apk add --no-cache libc6-compat

# Install pnpm globally
RUN npm install -g pnpm@11

# Set working directory
WORKDIR /app

# Copy everything to the working directory (except those listed in .dockerignore)
COPY . .

# Install dependencies
RUN pnpm install --frozen-lockfile
RUN pnpm run build

# Set environment variables and user
ENV NODE_ENV=production
RUN addgroup --system --gid 1001 nodejs && adduser --system --uid 1001 nodejs 
USER nodejs

# Start the application
CMD ["pnpm", "run", "start"]