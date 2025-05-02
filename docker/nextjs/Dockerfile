FROM node:18

WORKDIR /app

COPY package.json package-lock.json ./
COPY scripts ./scripts

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]