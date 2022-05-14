# FROM node:14.4.0-alpine 使用不可
FROM node:16.13.1-alpine

ARG WORKDIR
ARG API_URL

ENV HOME=/${WORKDIR} \
  LANG=C.UTF-8 \
  TZ=Asia/Tokyo \
  # これを指定しないとブラウザからhttp://localhost へアクセスすることができない。
  # コンテナのNuxt.jsをブラウザから参照するためにip:0.0.0.0に紐付ける
  # https://ja.nuxtjs.org/faq/host-port/
  HOST=0.0.0.0 \
  API_URL=${API_URL}

WORKDIR ${HOME}

# ローカル上のpackageをコンテナにコピーしてインストールする
# COPY package*.json ./
RUN apk update && npm install -g npm

COPY . ./

RUN npm run build

CMD ["npm", "run", "dev"]
