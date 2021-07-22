-- Adminer 4.8.1 MySQL 5.5.5-10.3.29-MariaDB-0+deb10u1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

INSERT INTO `user` (`id_user`, `username`, `realname`, `password`, `phone_number`, `level`) VALUES
(1,	'admin',	'Admin',	'fc76c84271df9bf15731a9013a67ed9942ae768f',	'123456789',	'admin')
ON DUPLICATE KEY UPDATE `id_user` = VALUES(`id_user`), `username` = VALUES(`username`), `realname` = VALUES(`realname`), `password` = VALUES(`password`), `phone_number` = VALUES(`phone_number`), `level` = VALUES(`level`);

INSERT INTO `user_settings` (`id_user`, `theme`, `signature`, `permanent_delete`, `paging`, `bg_image`, `delivery_report`, `language`, `conversation_sort`, `country_code`) VALUES
(1,	'green',	'false;--\r\nPut your signature here',	'false',	20,	'true;background.jpg',	'default',	'indonesian',	'asc',	'ID')
ON DUPLICATE KEY UPDATE `id_user` = VALUES(`id_user`), `theme` = VALUES(`theme`), `signature` = VALUES(`signature`), `permanent_delete` = VALUES(`permanent_delete`), `paging` = VALUES(`paging`), `bg_image` = VALUES(`bg_image`), `delivery_report` = VALUES(`delivery_report`), `language` = VALUES(`language`), `conversation_sort` = VALUES(`conversation_sort`), `country_code` = VALUES(`country_code`);

-- 2021-07-15 07:58:26
