# Build Phase

FROM node:16-alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm set strict-ssl false
RUN npm install
RUN npm set strict-ssl true
COPY . .
RUN npm run build

# End of build Phase

# Routing Phase

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html