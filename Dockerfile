FROM node:22-alpine AS dependencies
WORKDIR /src
COPY package*.json ./
RUN npm ci --omit=dev

FROM node:22-alpine AS builder
WORKDIR /src
COPY --from=dependencies /src/node_modules ./node_modules
COPY . .

FROM node:22-alpine AS production
RUN addgroup -S node-shipping && adduser -S node-shipping -G node-shipping
WORKDIR /src
COPY --from=builder /src ./
RUN chown -R node-shipping:node-shipping /src
USER appuser
EXPOSE 3001
ENV NODE_ENV=production
CMD ["node", "index.js"]