# Listmine

A new Flutter project.

## Getting Started

mysql  Ver 9.7.1 for Linux on x86_64 (MySQL Community Server - GPL) \
Flutter 3.44.8 • channel stable • https://github.com/flutter/flutter.git \
Dart 3.12.2 • DevTools 2.57.0 \
Nodejs v20.19.2
Nginx 1.26.3

## Conf Settings
 - backend/.env
 - mysql -u your_db_user -p < database.sql
 - for web server see default.nginx

## Run application
 - flutter build web
   - copy build/web in /var/www/ 
 - pm2 start backend/app.js --name "listmine"
\
\
Enjoy your app
