CREATE USER 'smsbox'@'localhost' IDENTIFIED BY 'smsbox';
CREATE DATABASE smsbox;
GRANT ALL PRIVILEGES ON smsbox.* TO 'smsbox'@'localhost';
FLUSH PRIVILEGES;
