# FROM oven/bun:alpine AS bun
FROM node:21.3.0-slim
# COPY --from=bun /usr/local/bin/bun /usr/local/bin
# install simple http server for serving static content
RUN npm install -g bun

# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./
# install project dependencies
# RUN ln -s /usr/local/bin/bun /usr/local/bin/bunx
RUN bun install
# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

# build app for production with minification
RUN bun run build

EXPOSE 8080
CMD [ "bun", "run" ,"http-server", "dist" ]