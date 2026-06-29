DROP PROCEDURE IF EXISTS create_t_user_100;

DELIMITER ;;

CREATE PROCEDURE create_t_user_100()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE table_name VARCHAR(32);
    DECLARE sql_text TEXT;

    WHILE i < 100 DO
        SET table_name = CONCAT('t_user_', LPAD(i, 2, '0'));
        SET sql_text = CONCAT(
            'CREATE TABLE IF NOT EXISTS `', table_name, '` (',
            '  `user_id` BIGINT UNSIGNED NOT NULL COMMENT ''用户id'',',
            '  `nick_name` VARCHAR(50) DEFAULT NULL COMMENT ''昵称'',',
            '  `avatar` VARCHAR(512) DEFAULT NULL COMMENT ''头像'',',
            '  `name` VARCHAR(20) DEFAULT NULL COMMENT ''真实姓名'',',
            '  `sex` TINYINT UNSIGNED DEFAULT NULL COMMENT ''性别: 0男, 1女, 2保密'',',
            '  `birthday` DATE DEFAULT NULL COMMENT ''出生日期'',',
            '  `city` INT DEFAULT NULL COMMENT ''所在地'',',
            '  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT ''创建时间'',',
            '  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT ''更新时间'',',
            '  PRIMARY KEY (`user_id`)',
            ') COMMENT=''用户信息表_',
            LPAD(i, 2, '0'),
            ''''
        );

        SET @sql_text = sql_text;
        PREPARE stmt FROM @sql_text;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        SET i = i + 1;
    END WHILE;
END;;

DELIMITER ;

CALL create_t_user_100();

DROP PROCEDURE IF EXISTS create_t_user_100;
