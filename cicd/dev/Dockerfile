FROM node:20-slim

RUN npm install -g pnpm
WORKDIR /app
COPY package.json server.js /app/
RUN pnpm install
COPY outputs/ /app/outputs/
EXPOSE 8080
ENTRYPOINT ["node", "server.js"]