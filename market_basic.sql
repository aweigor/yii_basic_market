/*
 Navicat Premium Data Transfer

 Source Server         : ampps_sql
 Source Server Type    : MySQL
 Source Server Version : 50637
 Source Host           : localhost:3306
 Source Schema         : market_basic

 Target Server Type    : MySQL
 Target Server Version : 50637
 File Encoding         : 65001

 Date: 29/10/2020 05:14:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attributes
-- ----------------------------
DROP TABLE IF EXISTS `attributes`;
CREATE TABLE `attributes` (
  `attr_id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_name` varchar(255) DEFAULT NULL,
  `attr_icon` varchar(255) DEFAULT NULL,
  `attr_measure` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order_products
-- ----------------------------
DROP TABLE IF EXISTS `order_products`;
CREATE TABLE `order_products` (
  `odpr_id` int(11) NOT NULL AUTO_INCREMENT,
  `ordpr_prod_id` int(11) NOT NULL,
  `ordpr_order_id` int(11) NOT NULL,
  `ordpr_measure` varchar(255) DEFAULT NULL,
  `ordpr_amount` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`odpr_id`),
  KEY `fk_order_products_products` (`ordpr_prod_id`),
  KEY `fk_order_products_orders` (`ordpr_order_id`),
  CONSTRAINT `fk_order_products_orders` FOREIGN KEY (`ordpr_order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_products_products` FOREIGN KEY (`ordpr_prod_id`) REFERENCES `products` (`prod_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_user_id` int(11) DEFAULT NULL,
  `order_cost` decimal(8,0) unsigned DEFAULT NULL,
  `order_datecreated` int(11) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_users` (`order_user_id`),
  CONSTRAINT `fk_orders_users` FOREIGN KEY (`order_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for product_attributes
-- ----------------------------
DROP TABLE IF EXISTS `product_attributes`;
CREATE TABLE `product_attributes` (
  `prat_id` int(11) NOT NULL,
  `prat_prod_id` int(11) DEFAULT NULL,
  `prat_attr_id` int(11) DEFAULT NULL,
  `prat_attr_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`prat_id`),
  KEY `fk_product_attributes_prod_id` (`prat_prod_id`),
  KEY `fk_product_attributes_attr_id` (`prat_attr_id`),
  CONSTRAINT `fk_product_attributes_attr_id` FOREIGN KEY (`prat_attr_id`) REFERENCES `attributes` (`attr_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_attributes_prod_id` FOREIGN KEY (`prat_prod_id`) REFERENCES `products` (`prod_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images` (
  `prim_id` int(11) NOT NULL AUTO_INCREMENT,
  `prim_prod_id` int(11) NOT NULL,
  `prim_name` varchar(255) NOT NULL,
  `prim_ext` varchar(255) NOT NULL,
  `prim_alt` varchar(255) DEFAULT NULL,
  `prim_isdeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`prim_id`),
  KEY `fk_product_images_products` (`prim_prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(255) DEFAULT NULL,
  `prod_desc` varchar(255) DEFAULT NULL,
  `prod_cost` decimal(10,0) unsigned DEFAULT NULL,
  `prod_remains` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_hash` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_address` varchar(255) DEFAULT NULL,
  `user_phone` varchar(255) DEFAULT NULL,
  `user_dateupdate` int(11) DEFAULT NULL,
  `user_datelogin` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user__isdeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
