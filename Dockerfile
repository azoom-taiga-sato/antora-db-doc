FROM node:20-slim

RUN npm install -g pnpm
WORKDIR /app
COPY package.json server.js /app/
RUN pnpm install
COPY public/ /app/public/
ENTRYPOINT ["node", "server.js"]