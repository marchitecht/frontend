# Stage 1: build
FROM node:20-alpine AS build

WORKDIR /app

# зависимости
COPY package.json package-lock.json ./
RUN npm ci

# ВАЖНО: копируем ВЕСЬ проект
COPY . .

# сборка
RUN npm run build

# Stage 2: production
FROM nginx:stable-alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
