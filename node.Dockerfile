FROM node:14-slim
#create app directory
WORKDIR /app
#ensure package json and package-lock.json are copied
#COPY package*.json ./
COPY server /app
#Install app dependencies
RUN npm install
#Bundle app source
#COPY . .
EXPOSE 3001

CMD npm start