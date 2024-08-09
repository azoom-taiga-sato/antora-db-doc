FROM node:20-slim

RUN npm install -g pnpm
WORKDIR /workspace
COPY package.json server.js /workspace/
RUN pnpm install
EXPOSE 8080
ENTRYPOINT ["node", "server.js"]