FROM ghcr.io/gmeligio/flutter-web:3.47.7 AS build

WORKDIR /app

RUN git config --global --add safe.directory /home/flutter/sdks/flutter

COPY --chown=flutter:flutter pubspec.yaml pubspec.lock ./

RUN flutter pub get

COPY --chown=flutter:flutter . .

RUN flutter build web --release

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 10000

CMD ["nginx", "-g", "daemon off;"]
