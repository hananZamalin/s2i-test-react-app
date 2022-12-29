#Build Steps
FROM node:16.3.0-alpine as build-step

RUN mkdir /app
WORKDIR /app

COPY package.json /app

RUN npm config set strict-ssl false
RUN npm install
COPY . /app

RUN npm run build

#Run Steps
FROM nginx:1.19.8-alpine  
COPY --from=build-step /app/build /usr/share/nginx/html
