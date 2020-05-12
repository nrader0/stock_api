CREATE DATABASE stock;
USE stock;


CREATE TABLE `config` (
  `config_id` int NOT NULL AUTO_INCREMENT,
  `parameter` varchar(45) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `config_unq_parameter` (`parameter`)
);

CREATE TABLE `stock` (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `symbol` varchar(45) NOT NULL,
  `company` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`stock_id`),
  UNIQUE KEY `stock_unq_symbol` (`symbol`)
);

CREATE TABLE `stock_value` (
  `stock_value_id` int NOT NULL AUTO_INCREMENT,
  `stock_id` int DEFAULT NULL,
  `value` float DEFAULT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stock_value_id`),
  UNIQUE KEY `stock_value_unq_stock_id_added_at` (`added_at`,`stock_id`),
  KEY `FK_stock_value_stock_idx` (`stock_id`),
  CONSTRAINT `FK_stock_value_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE VIEW `v_stock_value` AS
    SELECT
        `s`.`symbol` AS `symbol`,
        `s`.`company` AS `company`,
        `sv`.`value` AS `value`,
        `sv`.`added_at` AS `added_at`
    FROM
        (`stock_value` `sv`
        JOIN `stock` `s` ON ((`sv`.`stock_id` = `s`.`stock_id`)))
;

CREATE VIEW `v_profit` AS
    SELECT
        `s`.`company` AS `company`,
        ROUND((`new`.`value` - `old`.`value`), 2) AS `diff`,
        ROUND(((`new`.`value` / `old`.`value`) - 1), 4) AS `perc`
    FROM
        (((SELECT
            `so`.`stock_id` AS `stock_id`, `jo`.`value` AS `value`
        FROM
            ((SELECT
            `stock_value`.`stock_id` AS `stock_id`,
                MIN(`stock_value`.`stock_value_id`) AS `stock_value_id`
        FROM
            `stock_value`
        GROUP BY `stock_value`.`stock_id`) `so`
        JOIN `stock_value` `jo` ON (((`so`.`stock_id` = `jo`.`stock_id`)
            AND (`so`.`stock_value_id` = `jo`.`stock_value_id`))))) `old`
        JOIN (SELECT
            `sn`.`stock_id` AS `stock_id`, `jn`.`value` AS `value`
        FROM
            ((SELECT
            `stock_value`.`stock_id` AS `stock_id`,
                MAX(`stock_value`.`stock_value_id`) AS `stock_value_id`
        FROM
            `stock_value`
        GROUP BY `stock_value`.`stock_id`) `sn`
        JOIN `stock_value` `jn` ON (((`sn`.`stock_id` = `jn`.`stock_id`)
            AND (`sn`.`stock_value_id` = `jn`.`stock_value_id`))))) `new`)
        JOIN `stock` `s`)
    WHERE
        ((`old`.`stock_id` = `new`.`stock_id`)
            AND (`s`.`stock_id` = `new`.`stock_id`))
;
