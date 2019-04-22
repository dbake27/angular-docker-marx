# stage 1
# base image
FROM node:10-alpine as node
# working directory in image
WORKDIR /usr/src/app
#copy package.json and package-lock.json
COPY package*.json ./
# do npm install
RUN npm i npm@latest -g
RUN npm install
RUN npm audit fix
# copy all other files and folders exluding dist and nodemodules in
COPY . .
# build the dist contents
RUN npm run build

# Stage 2
FROM nginx:1.13.12-alpine

# copy our dist output from the node in stage 1 to this new image nginx public folder
COPY --from=node /usr/src/app/dist/angular-docker-marx /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf




