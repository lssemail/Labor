-- 用户表
--普通用户暂时不进入这个表，通过微信直接获取用户信息
--管理员加入此表
// 需要一个用户表，暂时存放用户微信名或ID， 手机号码和收货地址，这样第二次购买的用户可以通过此表信息获取
CREATE TABLE `labor`.`shopping_user` (
  `id` INT NOT NULL COMMENT '主键',
  `username` VARCHAR(50) NOT NULL COMMENT '用户名',
  `password` VARCHAR(50) NOT NULL COMMENT '密码',
  `address` VARCHAR(255) NULL COMMENT '用户地址',
  `tel` VARCHAR(50) NULL COMMENT '电话号',
  `mobile` VARCHAR(50) NULL COMMENT '手机号',
  `deleteflag` INT NULL DEFAULT 0 COMMENT '删除标志位',
  `createtime` DATETIME NULL COMMENT '创建时间',
  `user_type` INT NULL COMMENT '用户类型',
  `email` VARCHAR(50) NULL COMMENT '邮箱',
  PRIMARY KEY (`id`),
  INDEX `name_index` (`username` ASC));



// 这个推荐暂时在公共帐号里面吧？如果需要名字换为 periodical
--期刊表，表示第几期商品
CREATE TABLE `labor`.`shopping_period` (
  `id` INT NOT NULL COMMENT '期刊ID',
  `period` INT NULL COMMENT '期数',
  `theme` VARCHAR(45) NULL COMMENT '主题名称',
  PRIMARY KEY (`id`));


--商品表
// 商品列表页信息没有问题了， 详情页上面的图片可以为slides, 详情图片为detail_imgs, 存为一个字符串，多张图片使用分好或者逗号隔开
// 图片为必要使用缩略图和大图两个字段，我们存一个字段，固定缩略图url生成规则既可， 比如存123.jpg 转化 123_thumb.jpg，以后如果用第三方的cdn就更加没有必要了

CREATE TABLE `labor`.`shopping_goods` (
  `goods_id` INT NOT NULL COMMENT '商品ID',
  `name` VARCHAR(200) NULL COMMENT '名称',
  `sn` VARCHAR(200) NULL COMMENT '货号',
  `brand_id` INT NULL COMMENT '品牌ID',
  `cat_id` INT NULL COMMENT '所属分类ID',
  `period_id` INT NULL COMMENT '期刊ID',
  `market_enable` SMALLINT NULL COMMENT '是否上架',
  `price` DECIMAL NULL COMMENT '销售价格',
  `cost` DECIMAL NULL COMMENT '成本价',
  `mkt_price` DECIMAL NULL COMMENT '市场价',
  `create_time` DATETIME NULL COMMENT '创建时间',
  `love_count` INT NULL COMMENT '喜欢次数',    // 改为likes_count
  `buy_count` INT NULL COMMENT '购买次数',    // 改为sales
  `store` INT NULL COMMENT '库存',
  `intro` LONGTEXT NULL COMMENT '详细介绍',
  `pic_intro` LONGTEXT NULL COMMENT '图文详情',  // 这个暂时没有必要
  `thumbnail` LONGTEXT NULL COMMENT '缩略图',
  `big_jpg` LONGTEXT NULL COMMENT '大图',
  `p1` VARCHAR(255) NULL,    // 这些字段是干嘛的？？
  `p2` VARCHAR(255) NULL,
  `p3` VARCHAR(255) NULL,
  `p4` VARCHAR(255) NULL,
  `p5` VARCHAR(255) NULL,
  `p6` VARCHAR(255) NULL,
  `p7` VARCHAR(255) NULL,
  `p8` VARCHAR(255) NULL,
  `p9` VARCHAR(255) NULL,
  `p10` VARCHAR(255) NULL,
  PRIMARY KEY (`goods_id`));



--货品表
CREATE TABLE `labor`.`shopping_product` (
  `product_id` INT NOT NULL COMMENT '货品ID',
  `goods_id` INT NULL COMMENT '商品ID',
  `name` VARCHAR(45) NULL COMMENT '名称',
  `sn` VARCHAR(45) NULL COMMENT '货号',
  `price` DECIMAL NULL COMMENT '价格',
  `store` MEDIUMINT NULL COMMENT '库存',
  `specs` VARCHAR(45) NULL COMMENT '规格',   // 这个是货品属性字段是吧？多种属性按照固定格式生成一个字符串就好（颜色:红色;尺寸:L）
  PRIMARY KEY (`product_id`));


--库存表
// 这个应该暂时不需要
CREATE TABLE `labor`.`shopping_depot` (
  `id` INT NOT NULL,
  `name` VARCHAR(200) NULL COMMENT '库存地址',
  PRIMARY KEY (`id`));


--货品库存表
--这个表是为了定义多个库房的货品库存情况
// storeroom库房
CREATE TABLE `labor`.`shopping_product_store` (
  `id` INT NOT NULL,
  `goodid` INT NULL COMMENT '商品id',
  `productid` INT NULL COMMENT '货品id',
  `depotid` INT NULL COMMENT '库存id',
  `store` INT NULL COMMENT '库存量',
  PRIMARY KEY (`id`));


--订单表
CREATE TABLE `labor`.`shopping_order` (
  `id` INT NOT NULL,
  `sn` VARCHAR(200) NULL COMMENT '商品编号',
  `pay_status` INT NULL COMMENT '支付状态',
  `status` INT NULL COMMENT '订单状态',
  `ship_status` INT NULL COMMENT '发货状态',
  `createtime` DATETIME NULL COMMENT '订单创建时间',
  `shipping_type` VARCHAR(100) NULL COMMENT '配送方式',
  `payment_id` INT NULL COMMENT '支付id',
  `paymoney` DECIMAL NULL COMMENT '实际支付钱',
  `need_paymoney` DECIMAL NULL COMMENT '需要支付钱',
  `ship_moble` VARCHAR(45) NULL COMMENT '运送手机号',
  `ship_email` VARCHAR(45) NULL COMMENT '运送email',
  `goods_amount` DECIMAL NULL COMMENT '商品总价格',
  `shipping_amount` DECIMAL NULL COMMENT '运送价格',
  `order_amount` DECIMAL NULL COMMENT '订单价格',
  `ship_day` VARCHAR(45) NULL COMMENT '运送时间',
  `ship_address` VARCHAR(300) NULL COMMENT '运送地址',
  PRIMARY KEY (`id`));
  `shipping_area` VARCHAR(200) NULL COMMENT '运送区域',


--订单对应商品表
CREATE TABLE `labor`.`shopping_order_items` (
  `id` INT NOT NULL,
  `order_id` INT NULL COMMENT '订单id',
  `good_id` INT NULL COMMENT '商品id',
  `product_id` INT NULL COMMENT '货品id',
  `num` INT NULL COMMENT '购买数量',
  `price` DECIMAL NULL COMMENT '价格',
  `name` VARCHAR(200) NULL COMMENT '商品名称',
  PRIMARY KEY (`id`));


--订单操作日志
CREATE TABLE `labor`.`shopping_order_log` (
  `id` INT NOT NULL,
  `order_id` INT NULL COMMENT '订单id',
  `operator_id` INT NULL COMMENT '操作人id',
  `op_name` VARCHAR(200) NULL COMMENT '操作人名称',
  `message` VARCHAR(200) NULL COMMENT '操作信息',
  `op_time` DATETIME NULL COMMENT '操作时间',
  PRIMARY KEY (`id`));

--订单保存送货地址
CREATE TABLE `labor`.`shopping_member_address` (
  `id` INT NOT NULL,
  `user_id` INT NULL COMMENT '用户id',
  `region_id` INT NULL COMMENT '区域id',
  `region` VARCHAR(45) NULL COMMENT '区域名称',
  `city` VARCHAR(45) NULL COMMENT '城市',
  `province` VARCHAR(45) NULL COMMENT '省会',
  `address` VARCHAR(200) NULL COMMENT '详细地址',
  `zip` VARCHAR(45) NULL COMMENT '邮编',
  `tel` VARCHAR(45) NULL COMMENT '固定电话',
  `mobile` VARCHAR(45) NULL COMMENT '手机号',
  PRIMARY KEY (`id`));


--品牌表
--暂时不需要
CREATE TABLE `labor`.`shopping_brand` (
  `id` INT NOT NULL COMMENT '品牌id',
  `name` VARCHAR(200) NULL COMMENT '品牌名称',
  `url` VARCHAR(300) NULL COMMENT '品牌官网',
  PRIMARY KEY (`id`));


--分类表
--暂时不需要
CREATE TABLE `labor`.`shopping_cat` (
  `id` INT NOT NULL,
  `name` VARCHAR(200) NULL COMMENT '分类名称',
  PRIMARY KEY (`id`));



