# Stage 1: Install dependencies
FROM node:22-alpine AS dependencies
WORKDIR /src
COPY package*.json ./
RUN npm ci --omit=dev

# Stage 2: Build stage (copying app files)
FROM node:22-alpine AS builder
WORKDIR /src
COPY package*.json ./
COPY . .            
COPY --from=dependencies /src/node_modules ./node_modules

# Stage 3: Production image
FROM node:22-alpine AS production
RUN addgroup -S node-order && adduser -S node-order -G node-order
WORKDIR /src
COPY --from=builder /src ./
RUN chown -R node-order:node-order /src
USER node-order
EXPOSE 3000
ENV NODE_ENV=production
CMD ["node", "index.js"]
