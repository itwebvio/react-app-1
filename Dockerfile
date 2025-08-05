# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app

# Copy only package files first for caching
COPY package*.json ./

RUN npm install

# Copy the rest of the source code
COPY . .

RUN npm run build

# Stage 2: Serve
FROM node:18-alpine
WORKDIR /app

COPY --from=builder /app /app

EXPOSE 3000
CMD ["node", "dist/server.js"]  # Adjust for your entry point
