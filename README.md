# Listmine

A new Flutter project.

## Getting Started

mysql  Ver 9.7.1 for Linux on x86_64 (MySQL Community Server - GPL) \
Flutter 3.44.8 • channel stable • https://github.com/flutter/flutter.git \
Dart 3.12.2 • DevTools 2.57.0 \
Nodejs v20.19.2

## Conf Settings
 - backend/.env
 - lib/services/*.js ("static const String server=")
 - mysql -u your_db_user -p < database.sql

## Run application
 - flutter build web
 - pm2 start lib/app.js --name "listmine"
 - pm2 serve build/web/ 8080 --spa
\
\
Enjoy your app
