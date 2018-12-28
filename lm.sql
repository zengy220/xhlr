/*
Navicat MySQL Data Transfer

Source Server         : 问卷
Source Server Version : 50633
Source Host           : 193.112.18.247:3306
Source Database       : xh

Target Server Type    : MYSQL
Target Server Version : 50633
File Encoding         : 65001

Date: 2018-12-21 09:39:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cs_active_gift
-- ----------------------------
DROP TABLE IF EXISTS `cs_active_gift`;
CREATE TABLE `cs_active_gift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT '礼品名称',
  `points` int(10) DEFAULT '0' COMMENT '该活动礼品对应的积分数值',
  `addtime` int(10) DEFAULT NULL COMMENT '创建该类型产品的时间',
  `is_active` smallint(1) DEFAULT '1' COMMENT '是否参与活动 1参与0下架',
  `imagePath` varchar(100) DEFAULT NULL COMMENT '商品的图片地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='参于兑换活动的礼品表';

-- ----------------------------
-- Records of cs_active_gift
-- ----------------------------
INSERT INTO `cs_active_gift` VALUES ('1', '1', '10元酱香型槟榔', '100', null, '1', 'images/img1.jpg');
INSERT INTO `cs_active_gift` VALUES ('2', '2', '20元清香型槟榔', '200', null, '1', 'images/img2.jpg');

-- ----------------------------
-- Table structure for cs_ad_content
-- ----------------------------
DROP TABLE IF EXISTS `cs_ad_content`;
CREATE TABLE `cs_ad_content` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL COMMENT '标题',
  `ad_list_id` int(11) DEFAULT NULL COMMENT '所属广告位ID',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `url` varchar(100) DEFAULT NULL COMMENT '跳转地址',
  `img` text COMMENT '图片地址',
  `word` text COMMENT '文字',
  `addtime` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cs_ad_content
-- ----------------------------

-- ----------------------------
-- Table structure for cs_ad_list
-- ----------------------------
DROP TABLE IF EXISTS `cs_ad_list`;
CREATE TABLE `cs_ad_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `simple_code` varchar(50) DEFAULT NULL COMMENT '简码',
  `illustration` varchar(60) DEFAULT NULL COMMENT '说明',
  `addtime` varchar(15) DEFAULT NULL,
  `is_delete` int(3) DEFAULT '1' COMMENT '是否能删除（1能0不能）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cs_ad_list
-- ----------------------------

-- ----------------------------
-- Table structure for cs_company
-- ----------------------------
DROP TABLE IF EXISTS `cs_company`;
CREATE TABLE `cs_company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) DEFAULT '' COMMENT '组织名称',
  `company_type` tinyint(3) DEFAULT NULL COMMENT '组织类型(1总部，2分部)',
  `company_status` tinyint(3) DEFAULT '1' COMMENT '组织状态1正常0冻结',
  `company_num` varchar(11) DEFAULT '0' COMMENT '组织编号',
  `company_time` int(10) DEFAULT '0' COMMENT '组织创建时间',
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `company_name` (`company_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='组织(分公司)表';

-- ----------------------------
-- Records of cs_company
-- ----------------------------
INSERT INTO `cs_company` VALUES ('1', '总公司', '1', '1', '10', '1496304406');

-- ----------------------------
-- Table structure for cs_content_category
-- ----------------------------
DROP TABLE IF EXISTS `cs_content_category`;
CREATE TABLE `cs_content_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '节点ID',
  `tpcode` char(64) NOT NULL COMMENT '栏目简码',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `tpl` varchar(255) NOT NULL DEFAULT '' COMMENT '模板',
  `col_url` varchar(255) NOT NULL DEFAULT '' COMMENT '模板',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1启用',
  `thumb` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`tpcode`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='内容栏目表';

-- ----------------------------
-- Records of cs_content_category
-- ----------------------------
INSERT INTO `cs_content_category` VALUES ('41', 'LMCY', '0', '联盟成员', '', 'page_content', '/web/about/page_content', '1540265391', '1', '1', '/upfile/coloum/column1540265391.');
INSERT INTO `cs_content_category` VALUES ('42', 'SCTX', '41', '生产体系', '', 'page_content', '/web/about/page_content', '1540265532', '1', '1', '/upfile/coloum/column1540265532.');
INSERT INTO `cs_content_category` VALUES ('43', 'YXTX', '41', '营销体系', '', 'page_content', '/web/about/page_content', '1540265577', '2', '1', '/upfile/coloum/column1540265577.');
INSERT INTO `cs_content_category` VALUES ('44', 'ZZH', '41', '种植户', '', 'page_content', '/web/about/page_content', '1540265646', '3', '1', '/upfile/coloum/column1540265646.');
INSERT INTO `cs_content_category` VALUES ('46', 'LMJS', '0', '联盟介绍', '', 'content', '/web/about/content', '1540265732', '2', '1', '/upfile/coloum/column1540265732.');
INSERT INTO `cs_content_category` VALUES ('47', 'LMJSS', '46', '联盟介绍', '', 'content', '/web/about/content', '1540265782', '1', '1', '/upfile/coloum/column1540265782.');
INSERT INTO `cs_content_category` VALUES ('48', 'LMZC', '46', '联盟章程', '', 'content', '/web/about/content', '1540265810', '2', '1', '/upfile/coloum/column1540265810.');
INSERT INTO `cs_content_category` VALUES ('49', 'ZZJG', '46', '组织机构', '', 'content', '/web/about/content', '1540265838', '3', '1', '/upfile/coloum/column1540265838.');
INSERT INTO `cs_content_category` VALUES ('50', 'LDGL', '46', '领导关怀', '', 'content', '/web/about/content', '1541745421', '4', '1', '/upfile/coloum/column1540265869.');
INSERT INTO `cs_content_category` VALUES ('52', 'XJWWH', '0', '湘九味文化', '', 'content', '/web/about/content', '1540265976', '3', '1', '/upfile/coloum/column1540265976.');
INSERT INTO `cs_content_category` VALUES ('53', 'CGZS', '52', '成果展示', '', 'content', '/web/about/content', '1540266000', '1', '1', '/upfile/coloum/column1540266000.');
INSERT INTO `cs_content_category` VALUES ('54', 'JSPT', '52', '技术平台', '', 'content', '/web/about/content', '1540266024', '2', '1', '/upfile/coloum/column1540266024.');
INSERT INTO `cs_content_category` VALUES ('55', 'YXPT', '52', '运行平台', '', 'content', '/web/about/content', '1540266093', '3', '1', '/upfile/coloum/column1540266093.');
INSERT INTO `cs_content_category` VALUES ('56', 'LXWMS', '52', '联系我们', '', 'content', '/web/about/content', '1540266120', '4', '1', '/upfile/coloum/column1540266120.');
INSERT INTO `cs_content_category` VALUES ('57', 'HYMD', '46', '会员名单', '', 'content', '/web/about/content', '1541731787', '6', '1', '/upfile/coloum/column1541731071.');

-- ----------------------------
-- Table structure for cs_content_content
-- ----------------------------
DROP TABLE IF EXISTS `cs_content_content`;
CREATE TABLE `cs_content_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '节点ID',
  `col_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '栏目id',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `subtitle` varchar(255) DEFAULT NULL COMMENT '副标题',
  `contents` text NOT NULL COMMENT '栏目内容',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名称',
  `create_time` date NOT NULL DEFAULT '0000-00-00' COMMENT '发布时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(1:显示，0：隐藏)',
  `istop` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否置顶（1：置顶）',
  `description` varchar(255) DEFAULT NULL COMMENT '简介',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `list` (`col_id`,`status`,`id`),
  KEY `list2` (`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='内容基本表';

-- ----------------------------
-- Records of cs_content_content
-- ----------------------------
INSERT INTO `cs_content_content` VALUES ('53', '42', '湖南怀化龙成中药饮片有限责任公司', '', '<p>这是内容一</p>', '/upfile/content/content1540266407.jpg', '', '2018-10-23', '1', '0', '', '2018-12-21 09:18:21');
INSERT INTO `cs_content_content` VALUES ('54', '42', '湖南春光九汇现代中药有限公司', '', '<p>这是内容二</p>', '', '', '2018-10-23', '1', '0', '湖南春光九汇现代中药有限公司是湖南省政府国有资本经营平台——湖南兴湘投资控股集团有限公司控股的一家集中药饮片、中药超微饮片（中药超微配方', '2018-12-21 09:18:37');
INSERT INTO `cs_content_content` VALUES ('56', '43', '湖南莲冠湘莲食品有限公司', '', '<p><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 仿宋; font-size: 18.6667px; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2;\">湖南莲冠湘莲食品有限公司，成立于</span></span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 仿宋; font-size: 18.6667px; text-indent: 37.3333px; background-color: rgb(255, 255, 255); line-height: 2;\">2005年，是从事湘莲的种植、收购、加工、销售的工业企业。法人代表：胡正光；注册资金：500万元。采用“公司+协会+农户+基地”的订单种植经营模式，经过不断创新、拼搏、发展，目前我公司初具规模，总资产达3850万元，厂区面积7000平方。为保护湘莲品种和繁育，结合湘潭县种植结构调整，建设“寸三莲”原种基地（涓江村）300亩，四个湘莲繁育种植基地（马垅、金莲、紫荆、石鼓）4500亩（其中马垅、涓江是中国良好农业GAP示范基地），大力发展湘莲产业和生态种植，聘请湖南农科院教授进行品种提纯复壮低镉研发、高产生态栽培种植，既是环保型、节约型的新型湘莲工业企业，又是研发型的湘莲种植企业；是国内外多家知名品牌食品生产厂家的定点供应商，年产值、销售产值11018万元，利税1141万元。</span></p>', '', '', '2018-10-23', '1', '0', '湖南莲冠湘莲食品有限公司，成立于2005年，是从事湘莲的种植、收购、加工、销售的工业企业。法人代表：胡正光；注册资金：500万元。采用“公司', '2018-10-23 02:41:48');
INSERT INTO `cs_content_content` VALUES ('55', '47', '联盟简介', '', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">湖南省中药材产业联盟成立于2014年9月25日，是为深入实施国家技术创新工程，积极落实《湖南省人民政府办公厅关于加快发展中药材产业的意见》（[2014]80号）精神，推动中药材产业联盟的构建和发展，加快构建以企业为主体、市场为导向、产学研相结合的技术创新体系，在省经济和信息化委员会、省科技厅、省中医药管理局等相关单位指导下，由湖南农业大学曾建国教授倡议提出，联合省内从事中药材研究的高等院校、科研院所、种植和加工企业、种植专业合作社等89家单位共同发起，成立“湖南省中药材产业联盟”。截止目前为止，已发展到101家单位。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">本联盟以湖南农业大学国家中药材生产（湖南）技术中心作为本联盟的技术平台，以“湖南湘九味中药材开发有限公司”作为本联盟的运行平台，通过融合湖南省中药材产业相关资源，协同打造“湘九味”特色药材，提高中药材栽培技术、生产加工以及中药资源研发水平，提升湘产中药材品质及影响力，协调种植合作社、生产加工企业与高校及科研机构、中药材企业合作，突破影响产业发展的技术与市场的瓶颈，提供技术服务, 着力推动产业向品牌化、规范化、专业化方向发展，提升湖南省中药材的经济效益和社会效益，促进湖南省中药材产业的发展。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">联盟的成立将以打造“湘九味”，振兴“湘中药”为己任，加快中药材产业链相关资源的整合，协调种植合作社、生产加工企业与高校及科研机构的合作，着力推动产业向品牌化、规范化、专业化方向发展。他表示，联盟将强化服务意识，围绕省政府办公厅《关于加快中药材产业发展的意见》提出的目标和要求，积极推动基于地理标志特色与市场表现和系统性研究三个考量指标，从我省几十个特色品种中，通过10年左右的努力，协同打造9个具有强烈地域特征的特色药材，提升我省中药材栽培技术、生产加工以及中药资源研发整体水平。</p><p><br/></p>', '', '', '2018-10-23', '1', '0', '', null);
INSERT INTO `cs_content_content` VALUES ('59', '48', '联盟章程', '', '<p class=\"detail_cp\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; font-size: 14px; font-weight: bold; color: rgb(60, 60, 60); font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255);\">湖南省中药材产业联盟</p><p class=\"detail_cp\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; font-size: 14px; font-weight: bold; color: rgb(60, 60, 60); font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255);\">章&nbsp;&nbsp;&nbsp;程</p><p class=\"detail_cp\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; font-size: 14px; font-weight: bold; color: rgb(60, 60, 60); font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255);\">（初步定稿）</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">为明确湖南省中药材产业联盟（以下简称“联盟”）各方的职责、权利和义务，保证联盟的有效运行，特制订本章程。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第一章&nbsp;&nbsp;总&nbsp;&nbsp;则</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第一条&nbsp;本联盟全称为：湖南省中药材产业联盟。英文译文：Chinese&nbsp;Herbal&nbsp;Medicine&nbsp;Industry&nbsp;Alliance&nbsp;of&nbsp;Hunan，缩写为:“CHMIAH”。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第二条&nbsp;本联盟一个由积极投身于中药材事业，从事中药材管理、研发、生产、流通、加工等相关工作的企事业单位及其他相关机构自愿组成的学术性、行业性、非营利性的全省性社会团体。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第三条&nbsp;联盟宗旨：联盟遵守宪法、法律、法规和国家政策，遵守社会道德风尚，维护会员的合法权益。通过融合湖南中药材产业相关资源，协同打造&nbsp;“湘九味”特色中药材，提高中药材栽培或养殖管理、加工等生产技术以及中药资源研发水平，规范行业标准和从业人员素质，提升中药材经营企业的市场拓展能力，增强湘产中药材品质及品牌影响力，促进湖南省中药产业的发展。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第四条&nbsp;联盟接受政府、产业主管部门和社团登记管理机关的业务指导和监督管理。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第五条&nbsp;联盟住所为：湖南省长沙市芙蓉区湖南农业大学生命科学楼，邮编：410128</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第二章&nbsp;业务范围</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第六条&nbsp;&nbsp;本联盟主要业务范围：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;组织宣传、贯彻国家、湖南省及相关部门有关中药材产业发展的法规和政策，积极落实湖南省人民政府办公厅《关于加快发展中药材产业的意见》（以下简称《意见》）；摸清我省特色中药资源、技术力量及研究团队、种植或养殖品种及规模、加工生产等基础数据；为制订湖南省中药材产业发展规划出谋划策；发布本行业有关重大需求和信息，向省政府及产业主管部门报告本行业重大事宜。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;推动我省中药材产业向品牌化、规范化、专业化方向发展，提升湖南中药材产业的经济效益和社会效益，积极开展行业自律活动。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;以国家中药材生产（湖南）技术中心作为本联盟主要技术服务运行平台，促进政产学研用协同，协调或组织中药材种植（养殖）合作社、生产加工企业与高等院校、科研机构、中药材需求企业协作攻关，突破影响中药材产业发展的技术与市场关键瓶颈，提供技术咨询服务；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;组织开展省内外中药材科技、生产、市场等领域的交流与合作；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;开展优势中药材种植（养殖）、加工技术的示范推广与专业培训；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（六）&nbsp;组织出版湖南省中药材产业发展绿皮书；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（七）&nbsp;顶层设计我省中药资源基础研究和种植（养殖）与加工技术研究项目，向政府相关部门推荐以争取立项支持。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第七条&nbsp;本联盟主要活动地域：湖南省</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第三章&nbsp;联盟成员</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第八条&nbsp;&nbsp;本联盟的会员为单位会员。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第九条&nbsp;&nbsp;申请加入本联盟的会员，必须具备下列条件：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;遵循本联盟的章程，有加入本联盟的意愿；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;原则上具有独立法人资格；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;有良好经营业绩；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;加盟单位应为湖南省内从事中药材生产（包括种植或养殖合作社）、流通、加工（包括原料中药、中成药、保健食品、饲料及添加剂与兽药）相关工作，且有一定影响力的组织；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;遵守国家法律法规。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十条&nbsp;联盟成员的加入程序是：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;填写入盟申请表,提交联盟秘书处；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;联盟秘书处初审申请表并上报常务理事会；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;常务理事会审查批准；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;签署相关协议；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;成为联盟成员，颁发联盟证书。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十一条&nbsp;联盟成员享受下列权利:</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;参加联盟会员大会（理事会）；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;参加联盟组织的各项活动；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;审议联盟发展目标、长远规划、工作计划等；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;会员单位提名权、选举权与被选举权；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;联盟有关审议事项的提案权；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（六）&nbsp;审议需联盟成员大会（理事会）决定的其他事项;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（七）&nbsp;获得本联盟掌握的科技成果、资料和信息的优先权；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（八）&nbsp;在中药材生产行业的项目申请、参与、实施及完成过程中优先获得本联盟的指导和支持；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（九）&nbsp;对联盟工作的监督权和批评建议权；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（十）&nbsp;入会自愿，退会自由。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十二条&nbsp;联盟成员履行下列义务：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;遵守国家法律、法规和规章制度;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;遵守联盟章程，积极参加联盟组织的各项活动；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;维护联盟的信誉，不得以联盟的名义向个人、企业或其他组织摊派、乱收费等，不以联盟名义开展未经核准的业务；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;服从联盟领导，执行联盟常务理事会决议，努力完成联盟交办的工作任务；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;对联盟及其下属机构组织编发的有关信息资料，严格遵守保密制度；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（六）&nbsp;按规定交纳会费；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（七）&nbsp;成员单位应以书面形式推荐符合条件的人员担任联盟理事；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（八）&nbsp;成员单位应指定联络员一人（也可以是理事），及时向秘书处提供可对外发布的信息及业绩材料。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十三条&nbsp;联盟成员两年内不履行义务或不参加联盟活动，视为自动退出联盟。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十四条&nbsp;联盟成员退出，应书面报告的形式提交到联盟秘书处，经理事会或常务理事会表决通过，并交回有关证书。退出单位在联盟中一切权利和义务随之被取消。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十五条&nbsp;联盟成员如有严重违反本章程的行为，经常务理事会表决通过，予以除名。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第四章&nbsp;组织机构和负责人产生、罢免</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十六条&nbsp;联盟的组建形式：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;联盟由湖南农业大学倡议发起，联合省内从事中药资源研究的高等院校、科研机构、中药材种植（养殖）及加工企业、中药材需求企业和市场流通等组织发起成立；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;联盟成立后，符合条件的组织均可自愿申请加入，经联盟批准后成为会员；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;首届联盟常务理事由倡议发起单位提名产生，理事长、副理事长、秘书长由倡议发起单位提名，并经首次常务理事会选举产生。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;除（三）特别约定，常务理事会由联盟大会（理事会）选举产生，常务理事会选举产生理事长和副理事长、秘书长。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十七条&nbsp;联盟会员单位推荐代表为理事。联盟会员大会（理事会）是联盟的最高权力机构，其职权为：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;制定和修改联盟的章程；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;选举和罢免常务理事；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;讨论、决定联盟的发展方针与任务；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;表决通过秘书处推荐的常务理事；&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;审议和批准常务理事会的工作报告；&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（六）&nbsp;听取并审议秘书处的工作计划和工作报告；&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（七）&nbsp;审议和批准联盟的财务报告；&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（八）&nbsp;审议并决定本联盟其他重要事项。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十八条&nbsp;联盟会员大会（理事会）每2年召开一次，或由联盟常务理事会根据需要要求召开。会员大会（理事会）由理事长主持。会员大会（理事会）须有2/3以上的会员（理事）参加方能召开，其决议须经到会代表半数以上同意方能生效。需要时，也可采用通信形式召开。参会人员因故不能参加表决时，可以委托代表参加表决。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第十九条&nbsp;联盟常务理事会为联盟决策领导机构。其中设理事长1名、副理事长6-8名、秘书长1人、常务理事20-25人，每届5年，可连任。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第二十条&nbsp;联盟常务理事会每年至少召开一次会议，由理事长主持。常务理事会须有2/3以上的成员参加方能召开，其决议须到会代表半数以上同意方能生效。理事长可针对紧急重要的事情临时提请召开理事长会议，会后由秘书长将议事结果通报给各常务理事。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">联盟常务理事会职权为：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;执行联盟会员大会（理事会）的决议；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;筹备召开联盟会员大会（理事会）；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;选举和罢免理事长、副理事长、秘书长；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;筹集联盟所需经费；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;向理事会报告工作和财务状况；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（六）&nbsp;决定联盟会员的入会或除名；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（七）&nbsp;审定常务理事会工作计划，讨论和决定常务理事会重要工作和重大问题；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（八）&nbsp;决定联盟相关机构的设立；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（九）&nbsp;领导本联盟各机构开展工作；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（十）&nbsp;制定内部管理制度；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（十一）&nbsp;决定其它重大事项。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第二十一条&nbsp;联盟理事长、副理事长、秘书长必须具备下列条件：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（一）&nbsp;坚持党的路线、方针、政策，政治素质好；在联盟业务领域内有较大影响；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（二）&nbsp;身体健康，能坚持正常工作；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（三）&nbsp;理事长、副理事长、秘书长最高任职年龄不超过70岁；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（四）&nbsp;具有完全民事行为能力；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">（五）&nbsp;未受过剥夺政治权利的刑事处罚。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第二十二条&nbsp;本团体理事长、副理事长、秘书长如超过最高任职年龄的，须经常务理事会表决通过，报业务主管单位审查并社团登记管理机关批准同意后，方可任职。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 20px 0px 0px; text-indent: 2em; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">第二十三条&nbsp;联盟理事长为联盟的最</p><p><br/></p>', '', '', '2018-10-23', '1', '0', '', null);
INSERT INTO `cs_content_content` VALUES ('57', '44', '安化县李家山中药材种植专业合作社', '', '<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255); margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255); margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">&nbsp;安化县李家山中药材种植专业合作社</span></span></p><p><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">安化县李家山中药材种植专业合作社是一家专注于中药材育种、栽培和销售的农民专业合作社，由</span></span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255); line-height: 2;\">7</span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">位同村农民股东联合发起成立，致力于发展中医药健康产业，带领乡亲们共同致富，共吸纳贫困户65</span></span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">户，贫困人口238</span></span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">人。我社于2016</span></span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">年3</span></span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">月28</span></span><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\">日正式成立，办公地点设在环境优美、生态良好的大福镇天罩山村，法人代表为宁军华，理事长为肖利初。</span></span></p><p><span style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 18.6667px; text-align: justify; text-indent: 37.3333px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; line-height: 2; font-size: 16px;\"><img src=\"/ueditor/php/upload/image/20181111/1541922044597695.jpg\" title=\"1541922044597695.jpg\" alt=\"3b57aa25b5fda6c8daa52235d5c43d16.jpg\" width=\"297\" height=\"220\"/></span></span></p>', '', '', '2018-10-23', '1', '0', '', '2018-11-11 03:41:35');
INSERT INTO `cs_content_content` VALUES ('60', '49', '组织机构', '', '<p><img src=\"/ueditor/php/upload/image/20181023/1540277075477394.jpg\" title=\"1540277075477394.jpg\" alt=\"org.jpg\"/></p>', '', '', '2018-10-23', '1', '0', '', null);
INSERT INTO `cs_content_content` VALUES ('61', '50', '领导关怀', '', '<div class=\"maxbox fl bgf3f5ec insidecon\" style=\"margin: 0px; padding: 20px 0px; float: left; width: 960px; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(237, 244, 236);\"><div class=\"w960\" style=\"margin: 0px auto; padding: 0px; width: 960px;\"><div class=\"w960 fl platebg\" style=\"margin: 0px auto; padding: 0px; float: left; width: 960px; position: relative; background: rgb(255, 255, 255);\"><div class=\"show\" style=\"margin: 20px; padding: 0px; font-size: 15px; line-height: 24px;\"><div class=\"detail\" style=\"margin: 0px auto; padding: 28px 0px; min-height: 800px; width: 920px;\"><div class=\"detail_content\" style=\"margin: 0px; padding: 0px; width: 920px; min-height: 550px; font-size: 14px;\"><table width=\"900\" style=\"width: 768px;\"><tbody><tr class=\"firstRow\"><td align=\"center\" valign=\"middle\"><img title=\"08 省经信委各位领导和工作人员在商讨活动事宜.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277121760930.jpg\"/></td><td width=\"450\" align=\"center\" valign=\"middle\"><img width=\"400\" height=\"266\" title=\"2014年9月25日，联盟各单位参加由经信委主办国家中药材生产（湖南）技术中心承办的湖南省中药产业合作对接会.jpg\" alt=\"2014年9月25日，联盟各单位参加由经信委主办国家中药材生产（湖南）技术中心承办的湖南省中药产业合作对接会.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277121108767.jpg\"/></td></tr><tr><td align=\"center\">省经信委各位领导和工作人员在商讨活动事宜</td><td width=\"450\" align=\"center\">2014年9月25日，联盟各单位参加由经信委主办国家中药材生产（湖南）技术中心承办的湖南省中药产业合作对接会</td></tr><tr><td align=\"center\"><img title=\"湖南省中药材产业联盟筹备成立大会-1.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277121285386.jpg\"/></td><td width=\"450\" align=\"center\"><img width=\"400\" height=\"266\" title=\"湖南农业大学曾建国教授接受猪场动力记者的采访.jpg\" alt=\"湖南农业大学曾建国教授接受猪场动力记者的采访.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277121316283.jpg\"/></td></tr><tr><td align=\"center\">湖南省中药材产业联盟筹备成立大会</td><td width=\"450\" align=\"center\">湖南农业大学曾建国教授接受猪场动力记者的采访</td></tr><tr><td align=\"center\"><img title=\"省经信委主任，党组书记谢超英在大会上发言.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277121504547.jpg\"/></td><td width=\"450\" align=\"center\"><img width=\"400\" height=\"266\" title=\"联盟召开第一次理事长会议，就联盟运作等各方面问题进行商议.jpg\" alt=\"联盟召开第一次理事长会议，就联盟运作等各方面问题进行商议.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277122518446.jpg\"/></td></tr><tr><td align=\"center\">省经信委主任，党组书记谢超英在大会上发言</td><td width=\"450\" align=\"center\">联盟召开第一次理事长会议，就联盟运作等各方面问题进行商议</td></tr><tr><td align=\"center\"><img title=\"1.jpg\" alt=\"1.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277122130851.jpg\"/></td><td width=\"450\" align=\"center\"><img width=\"400\" height=\"266\" title=\"联盟理事长单位湖南农业大学与新晃龙脑樟生物科技有限公司签署技术服务协议.jpg\" alt=\"联盟理事长单位湖南农业大学与新晃龙脑樟生物科技有限公司签署技术服务协议.jpg\" src=\"/ueditor/php/upload/image/20181023/1540277122244119.jpg\"/></td></tr><tr><td align=\"center\">产业联盟理事长曾建国教授，副理事长张水寒教授等与会</td><td width=\"450\" align=\"center\">联盟理事长单位湖南农业大学与新晃龙脑樟生物科技有限公司签署技术服务协议</td></tr></tbody></table></div></div></div></div></div></div><div class=\"maxbox fl link\" style=\"margin: 0px; padding: 20px 0px; float: left; width: 960px; background: rgb(255, 255, 255); font-size: 14px; line-height: 36px; border-top: 2px solid rgb(14, 157, 15); color: rgb(60, 60, 60); font-family: 微软雅黑; white-space: normal;\"><div class=\"w960\" style=\"margin: 0px auto; padding: 0px; width: 960px;\"><ul class=\" list-paddingleft-2\" style=\"margin: 0px; padding: 0px;\"></ul></div></div><p><br/></p>', '', '', '2018-10-23', '1', '0', '', '2018-11-09 02:41:31');
INSERT INTO `cs_content_content` VALUES ('63', '53', '成果展示', '', '<p><img src=\"/ueditor/php/upload/image/20181025/1540434757104588.png\" title=\"1540434757104588.png\" alt=\"2018-10-25_102744322.png\"/></p>', '', '', '2018-10-25', '1', '0', '', '2018-10-25 10:32:44');
INSERT INTO `cs_content_content` VALUES ('64', '57', '会员名单', '', '<div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">长沙市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南农业大学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南中医药大学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省中医药研究院&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南名源堂中医药发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省农业科学院&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省植物提取物协会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省林业科学院&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省森林植物园&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南美可达生物资源有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙德中堂生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南加农正和生物技术有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省致远农业科技发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>浏阳市康鑫中药科技有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>浏阳市淳农种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省食品药品检验研究院&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南然润堂中药有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南蚕桑科学研究所&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南汉元生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南湘九味中药材开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南共享现代农业综合开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南麓园银杏产业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南春光九汇现代中药有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙众强科技开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南新汇制药股份有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南天大生物科技股份有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙市望峰农业技术发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙宝阳农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南福华特种种植发展有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙耿铭农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>宁乡畅逸中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>宁乡县孙家洞中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>宁乡县白洋中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙广吉农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙慧日生物技术有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>宁乡望北峰药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙和茂农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南方盛制药股份有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南湘楚传统医药传承推广中心&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙医学院&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南天地恒一制药有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南粒丰生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南青柳源生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南菲托葳植物资源有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南春光现代农业公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南明和农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>长沙绿丰源生物有机肥料有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南淳芝宝药业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">株洲市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>株洲松本药业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南宏邦生物科技科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>株洲市贾岭中药种植合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南千金药材有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南神农林下中药开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>株洲千金药业股份有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>醴陵市顺鑫中药材种植农民专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>炎陵县九都中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>茶陵县潞源生态种养农民专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">湘潭市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湘潭县莲都湘莲专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省湘莲产业技术创新战略联盟&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湘潭佳佳中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">衡阳市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>常宁市辉煌生态农业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>衡东县源发百果种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>耒阳市湘岐中药材加工种植合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南山仓农林综合开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南湘南药业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>耒阳市富农农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>绿佰珍生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">邵阳市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省新宁县中药材开发管理办公室&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省宝庆农产品进出口有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>隆回大健康产业园投资开发建设有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>武冈市医药有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南廉桥药都医药有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省新宁县永鑫药材开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>隆回县金丰金银花种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新邵县常春藤中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>绥宁绿洲林源天麻专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>邵东县本草堂中药材种植农民专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新宁县泰阳中药材种植有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新宁县瑶山中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>隆回县鸿鑫金银花种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>绥宁县博世康天麻科技开发有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南檀瑞农业科技开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南雨泉农业发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>邵阳县雄兴药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>隆回宝和种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新宁县大兴玉竹种植合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新宁县大红铁皮石斛种植合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>隆回县许丰现代农业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>邵阳县神农油茶专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新邵县向上中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省龙的传人药业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南邵东廉桥药材市场&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新宁县舜帝茶业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南鸿利药业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>武冈市民富中药材专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>绥宁县神农金康药用植物科技开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南盛世丰花生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">岳阳市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南宏富农牧业发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>临湘市中药饮片加工厂&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>岳阳莲世界科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省雅迭香科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>平江县慕平中医药文化产业园有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>岳阳嘉联生态农业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>华容县保丰中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>岳阳市君山莲都莲业专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>临湘市三祥艾叶专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>华容县智宸药业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南天岳黄精生态产业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>岳阳市富仁生态农业发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>同仁堂平江白术有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">张家界市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界广惠中药材专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界众信百合生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界仙踪林农业科技开发公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县德聚堂中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>桑植县万祥中药材农民专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南乾坤生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界本草科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利重楼中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南汉峰中药材开发有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县杜仲之香专业技术协会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县绿源杜仲种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界嘉泰种植有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南神舟中药饮片有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县德康中药材种植专业合作社零阳镇&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县华宏中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县道人山中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县康宁中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县龙锋中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县富农中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县中山中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县金岩山中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县福康中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县利福百合中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县惠农金银花中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县金常村中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县景龙桥中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县椿茂中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县武陵山中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县星明中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界凌云中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县集牛村中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县杰成中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县双合中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县际盛中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县信后天中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县造化中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界太坪中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县次建中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县五雷山玉竹专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县三合口乡旺农中药材专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县永丰泰中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县槐树村尾参种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县广达中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县康家坪村黄姜种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县青龙兄弟中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县钟山四季金银花中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县林茂杜仲中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县水田杜仲中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县花合杜仲中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县顺康杜仲中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县久天黄姜中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县春祥中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界新安神养殖专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县政权林木种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县艺歼中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县勇伟生态农业观光有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县鸿泰农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界汇湘农博园有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界星旗农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界万丰达生态农业发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县四知堂中药材开发有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界茶坤缘生物科技开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界绿原农林经济发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界长青农业综合开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县恒丰中药材科技发展有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界仲生 堂杜仲酒业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界德聚堂中药材开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县宏达农林开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利小玲农业开发基地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南歇驾庄农业发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南绿大农林经济发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县吉平家庭农场&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界隆盛农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县涵涵家庭农场&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界久日生物科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县民成农业科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县绿之禾生态农业科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县御品农业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>张家界新升农林科技开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利县玉竹专业技术协会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>慈利武陵山中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">益阳市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南汉森制药股份有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>安化县三军中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南益森沅江枳壳中药研究所&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>沅江市飞跃农业科技开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>益阳市资阳区杨林坳金银花种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>安化县利民中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>安化县厚朴种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南方腾农牧科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>益阳市资阳区鑫磊中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>桃江县天时农业发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>安化希尔康药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>安化县中医药健康产业协会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南上药中药材发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">常德市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>药圣堂（湖南）制药有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>石门县药用动植物产销协会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>汉寿县千弘中药材种植合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>津市市菲托葳中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南地本中药材种植有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>石门县圣波中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>澧县明鑫香橼中药材有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">娄底市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县绿源农林科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县天华中药材种植合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县颐朴源黄精科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>双峰县福泰种植农民专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化九鼎生态农业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县官渡中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县美华农林牧业开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县见阳岭中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县清凉农林旅游开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县高田中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南省新化县光彩中药材种植研究示范场&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县天龙山红豆杉种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县半山峰农林发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县天龙山农林科技开发有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县唐奇中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南福泰中药饮片有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>涟源市回春堂药材种植有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县熠峰中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化喜文中药材种植专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化百芝秀农业科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化杏林医院&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县新都栀子专业合作社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化县康福堂中药材发展有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化康福中药材开发公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化正君堂中医馆&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>新化正升大药房&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-张直武&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-邓爱新&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-卢家捌&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-卢志充&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-邹国平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-伍锡全&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-奉光铁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗教田&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗万福&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗崇华&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-廖安球&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗碧山&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-陈艳&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-杨加胜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-康小林&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-邹联武&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-李召均&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-戴丙华&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-王丽云&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-伍芬益&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-周菊华&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-成其虎&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-陆掌秀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-成其勇&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-扶克权&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-伍向平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-侯光辉&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-谭春色&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-冯永汉&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-孙益锋&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-曾勇谋&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-尹甫忠&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗孝平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗辉&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-奉荣华&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-陆绪忠&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-陈日星&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-陈福星&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-刘平南&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-廖永生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-奉西姑&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-王槐利&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-吴具清&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-曾永胜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-吴建华&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-吴梓仁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-吴东周&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗海根&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-李基春&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-罗枝林&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-伍玉军&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-杨育桂&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-曾礼红&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-伍平峰&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-周木友&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-游栋&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-杨建华&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-卢黎旺&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-谢湘美&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>种植大户-曹向雄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></li></ul></div></div><div class=\"fr w280 platebg\" style=\"margin: 0px; padding: 0px; float: right; width: 890px; position: relative; color: rgb(60, 60, 60); font-family: 微软雅黑; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 24px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(255, 255, 255);\"><div class=\"title02 title02red\" style=\"margin: 0px 10px; padding: 7px 0px 5px; height: 24px; line-height: 24px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(210, 55, 0);\"><em style=\"float: left;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/img08.png\"/></em><strong class=\"red\" style=\"float: left; margin: 0px 10px; font-size: 17px; font-weight: normal;\">郴州市</strong><em class=\"img02\" style=\"float: left; padding-top: 8px;\"><img alt=\"\" src=\"http://www.hnzyclm.com/hngap/static/hngap2/images/arrow09.gif\"/></em></div><div class=\"maxbox fl list02\" style=\"margin: 0px; padding: 0px; float: left; width: 890px; overflow: hidden;\"><ul class=\" list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>湖南利诺生物药业有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;\">●</span>郴州大诚中药饮片有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"Apple-converted-space\">&nbsp;</span><span class=\"btn\" style=\"margin: 0px; padding: 0px;', '', '', '2018-11-09', '1', '0', '', '2018-11-09 11:16:43');
INSERT INTO `cs_content_content` VALUES ('65', '50', '中国（龙山）2018年土家药产业发展论坛', '', '<p style=\"text-align: center; text-indent: 2em;\"><strong><span style=\"font-size:19px;font-family:宋体\"><br/></span></strong></p><p style=\"text-indent: 2em;\"><strong><span style=\"font-size:19px;font-family:宋体\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中国（龙山）2018年土家药产业发展论坛在湘西龙山县举行</span></strong></p><p style=\"text-align: left; text-indent: 2em;\"><span style=\"text-indent: 28px; font-size: 19px; font-family: 宋体; color: rgb(85, 85, 85); background: white;\">8</span><span style=\"text-indent: 28px; font-size: 19px; font-family: 宋体; color: rgb(85, 85, 85); background: white;\">月7日至9日，由中国民族医药学会和龙山县人民政府共同主办的“中国（龙山）2018年土家药产业发展论坛”在湘西自治州龙山县举行。</span><br/></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-size:19px;font-family:宋体;color:#555555;background:white\">国家中医药管理局原副局长、中国民族医学会原会长诸国本，中国中药协会执行副会长王瑛，湖南省中医药和中西医结合学会会长邵湘宁，湘西州委常委、龙山县委书记周云，龙山县副县长李冬梅等领导出席。</span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-size:19px;font-family:宋体;color:#555555;background:white\">中国民族医学会、中国医学科学院、中国中药协会、南京农业大学中药材研究所、湖南省中医药管理局、湖南省中药材产业协会（以下简称省协会）、湖南省农业科学院、湖南农业大学、湖南省中医药研究院、山东省农业厅、湖北省巴东县及部分中药材行业等相关领导和专家参加本次论坛；湖南湘九味中药材开发有限公司、山东合众正源现代中药饮片公司等企业代表应邀参加。</span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-size:19px;font-family:宋体;color:#555555;background:white\">本次大会由中国民族医药学会主办，由龙山县人民政府和中国民族医药学会土家医药分会承办，由中国中药协会协办，主题为“弘扬民族医药特色，助推龙山药材产业发展”。大会旨在共享全国先进技术经验,弘扬土家药产业文化，搭建土家药开发商贸洽谈平台，促进龙山县脱贫发展。</span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"background-color: white; color: rgb(85, 85, 85); font-family: 宋体; font-size: 19px;\">论坛上，国家中药材产业技术体系岗位科学家、省协会会长、湖南农业大学曾建国教授以《龙山县中药材产业发展分析》为主题作了报告，同时省协会专家委员会副主任委员张水寒研究员（湖南省中医药研究院中药研究所所长）、朱校奇研究员（湖南省农业科学院）以《湖南中药材资源分析与评估》、《龙山县百合产业发展商榷》为主题发表演讲。</span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-size:19px;font-family:宋体;color:#555555;background:white\">长期以来，土家医药在土家族疾病预防、保健、治疗、康复等方面发挥了重要作用，并随着社会发展、文化交流逐步走向世界，为世界所认同。在接受媒体访问时，曾建国教授提出，“龙山是国家级贫困县，位置偏远，能够举行这样大型的土家药产业发展论坛，很不容易，要利用这个契机，把龙山丰富的药材资源在全国进行推广和宣传。具体到龙山，这里素有‘百合之乡’的美誉，我认为应该以百合产业作为切入点，形成一个百合的集散地，把品牌做强做大，从而带动其他中药材产业发展。”</span></p>', '/upfile/content/content1541832628.jpg', '', '2018-11-10', '1', '0', '中国（龙山）2018年土家药产业发展论坛在湘西龙山县举行', '2018-11-11 03:52:34');

-- ----------------------------
-- Table structure for cs_menu
-- ----------------------------
DROP TABLE IF EXISTS `cs_menu`;
CREATE TABLE `cs_menu` (
  `menu_Id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(20) DEFAULT NULL COMMENT '菜单名字',
  `menu_url` varchar(50) DEFAULT NULL,
  `menu_sort` int(11) DEFAULT '0',
  `menu_status` int(1) DEFAULT '1' COMMENT '菜单状态（0不使用，1使用）',
  `menu_show` int(1) NOT NULL DEFAULT '0' COMMENT '是否显示（0不显示，1显示）',
  `relation_Id` int(11) DEFAULT NULL COMMENT '菜单关联ID',
  `add_time` varchar(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`menu_Id`),
  KEY `relation_Id` (`relation_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='后台菜单表';

-- ----------------------------
-- Records of cs_menu
-- ----------------------------
INSERT INTO `cs_menu` VALUES ('1', '系统管理', '', '0', '1', '1', '0', '1494846157');
INSERT INTO `cs_menu` VALUES ('2', '菜单列表', '/Home/User/menu_list', '1', '1', '1', '1', '1495015736');
INSERT INTO `cs_menu` VALUES ('56', '修改菜单', '/Home/User/menu_set', '0', '1', '1', '2', '1494847466');
INSERT INTO `cs_menu` VALUES ('57', '删除菜单', '/Home/User/menu_del', '0', '1', '1', '2', '1494847489');
INSERT INTO `cs_menu` VALUES ('58', '添加菜单', '/Home/User/menu_add', '0', '1', '1', '2', '1494848888');
INSERT INTO `cs_menu` VALUES ('59', '员工列表', '/Home/User/user_list', '3', '1', '0', '1', '1541389827');
INSERT INTO `cs_menu` VALUES ('60', '角色列表', '/Home/User/roleList', '2', '1', '0', '1', '1541389812');
INSERT INTO `cs_menu` VALUES ('61', '角色添加', '/Home/User/roleAdd', '0', '1', '1', '60', '1494851328');
INSERT INTO `cs_menu` VALUES ('62', '组织列表', '/Home/Company/company_list', '1', '1', '0', '1', '1541389798');
INSERT INTO `cs_menu` VALUES ('63', '栏目管理', '', '10', '1', '1', '0', '1494987216');
INSERT INTO `cs_menu` VALUES ('64', '栏目设置', '/Home/Column/index', '0', '1', '1', '63', '1495525870');
INSERT INTO `cs_menu` VALUES ('65', '栏目内容', '/Home/Column/content_list', '1', '1', '1', '63', '1494987356');
INSERT INTO `cs_menu` VALUES ('66', '广告管理', '', '11', '1', '1', '0', '1495162327');
INSERT INTO `cs_menu` VALUES ('67', '广告位设置', '/Home/Advertise/ad_list', '0', '1', '1', '66', '1494987491');
INSERT INTO `cs_menu` VALUES ('68', '广告内容', '/Home/Advertise/ad_content_list', '1', '1', '1', '66', '1494987551');
INSERT INTO `cs_menu` VALUES ('69', '系统首页', '/Home/User/index', '0', '1', '0', '1', '1495015079');
INSERT INTO `cs_menu` VALUES ('77', '员工列表删除', '/Home/User/user_del', '0', '1', '1', '59', '1496386996');
INSERT INTO `cs_menu` VALUES ('78', '员工列表修改', '/Home/User/user_edit', '0', '1', '1', '59', '1496387045');
INSERT INTO `cs_menu` VALUES ('79', '员工列表添加', '/Home/User/user_add', '0', '1', '1', '59', '1496387650');
INSERT INTO `cs_menu` VALUES ('80', '组织列表删除', '/Home/Company/company_del', '0', '1', '1', '62', '1496387724');
INSERT INTO `cs_menu` VALUES ('81', '编辑组织页面', '/Home/Company/company_update_html', '0', '1', '1', '62', '1496387764');
INSERT INTO `cs_menu` VALUES ('82', '编辑组织动作', '/Home/Company/company_update', '0', '1', '1', '62', '1496388493');
INSERT INTO `cs_menu` VALUES ('83', '添加组织页面', '/Home/Company/company_add_html', '0', '1', '1', '62', '1496388565');
INSERT INTO `cs_menu` VALUES ('84', '添加组织动作', '/Home/Company/company_add', '0', '1', '1', '62', '1496388600');
INSERT INTO `cs_menu` VALUES ('85', '角色编辑', '/Home/User/roleEdit', '0', '1', '1', '60', '1496388808');
INSERT INTO `cs_menu` VALUES ('86', '角色删除', '/Home/User/roleDel', '0', '1', '1', '60', '1496388851');
INSERT INTO `cs_menu` VALUES ('87', '重置密码', '/Home/User/edit_pwd', '0', '1', '1', '59', '1496393396');
INSERT INTO `cs_menu` VALUES ('98', '所属客服', '/Home/User/ajax_kefu', '0', '1', '1', '59', '1497230348');
INSERT INTO `cs_menu` VALUES ('99', '所属区域经理', '/Home/User/ajax_kefu2', '0', '1', '1', '59', '1497230400');

-- ----------------------------
-- Table structure for cs_role
-- ----------------------------
DROP TABLE IF EXISTS `cs_role`;
CREATE TABLE `cs_role` (
  `role_Id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL COMMENT '角色名',
  `role_identity` tinyint(3) DEFAULT NULL COMMENT '角色区分(0总部角色，1分部角色)',
  `role_position` tinyint(3) DEFAULT '5' COMMENT '0系统管理员，1区域经理，2客服，3业务员，4财务',
  `role_type` int(1) DEFAULT '1' COMMENT '角色类型(0系统角色,1自定义角色)',
  `role_status` int(1) DEFAULT '1' COMMENT '角色状态（0不使用，1使用）',
  `role_num` tinyint(3) NOT NULL DEFAULT '0' COMMENT '角色编号',
  `add_time` varchar(11) DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`role_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of cs_role
-- ----------------------------
INSERT INTO `cs_role` VALUES ('1', '超级管理员', '0', '0', '0', '1', '0', '1498182684');
INSERT INTO `cs_role` VALUES ('2', '总部管理员', '0', '0', '0', '1', '0', '1499747950');
INSERT INTO `cs_role` VALUES ('8', '分公司管理员', '1', '0', '0', '1', '0', '1497249100');
INSERT INTO `cs_role` VALUES ('9', '客服', '1', '2', '1', '1', '20', '1497323327');

-- ----------------------------
-- Table structure for cs_rolemenu
-- ----------------------------
DROP TABLE IF EXISTS `cs_rolemenu`;
CREATE TABLE `cs_rolemenu` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `role_Id` varchar(20) DEFAULT NULL,
  `menu_Id` varchar(20) DEFAULT NULL,
  `addtime` varchar(20) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`Id`),
  KEY `menu_Id` (`menu_Id`),
  KEY `role_Id` (`role_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4564 DEFAULT CHARSET=utf8 COMMENT='后台角色菜单表';

-- ----------------------------
-- Records of cs_rolemenu
-- ----------------------------
INSERT INTO `cs_rolemenu` VALUES ('56', '5', '1', '1490264531');
INSERT INTO `cs_rolemenu` VALUES ('57', '5', '2', '1490264531');
INSERT INTO `cs_rolemenu` VALUES ('58', '5', '5', '1490264531');
INSERT INTO `cs_rolemenu` VALUES ('59', '5', '6', '1490264531');
INSERT INTO `cs_rolemenu` VALUES ('60', '5', '8', '1490264531');
INSERT INTO `cs_rolemenu` VALUES ('63', '6', '1', '1490265235');
INSERT INTO `cs_rolemenu` VALUES ('64', '6', '2', '1490265235');
INSERT INTO `cs_rolemenu` VALUES ('3499', '8', '1', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3500', '8', '69', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3501', '8', '62', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3502', '8', '60', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3503', '8', '59', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3504', '8', '77', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3505', '8', '78', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3506', '8', '79', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3507', '8', '87', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3508', '8', '98', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3509', '8', '99', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3510', '8', '21', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3511', '8', '26', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3512', '8', '24', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3513', '8', '25', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3514', '8', '75', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3515', '8', '76', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3516', '8', '90', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3517', '8', '100', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3518', '8', '51', '1497249100');
INSERT INTO `cs_rolemenu` VALUES ('3625', '20', '1', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3626', '20', '69', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3627', '20', '2', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3628', '20', '56', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3629', '20', '57', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3630', '20', '58', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3631', '20', '62', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3632', '20', '80', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3633', '20', '81', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3634', '20', '82', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3635', '20', '83', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3636', '20', '84', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3637', '20', '60', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3638', '20', '61', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3639', '20', '85', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3640', '20', '86', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3641', '20', '59', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3642', '20', '77', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3643', '20', '78', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3644', '20', '79', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3645', '20', '87', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3646', '20', '98', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3647', '20', '99', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3648', '20', '21', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3649', '20', '26', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3650', '20', '24', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3651', '20', '25', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3652', '20', '75', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3653', '20', '76', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3654', '20', '90', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3655', '20', '100', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3656', '20', '51', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3657', '20', '89', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3658', '20', '52', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3659', '20', '88', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3660', '20', '27', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3661', '20', '31', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3662', '20', '29', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3663', '20', '38', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3664', '20', '36', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3665', '20', '37', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3666', '20', '41', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3667', '20', '42', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3668', '20', '43', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3669', '20', '44', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3670', '20', '45', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3671', '20', '46', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3672', '20', '47', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3673', '20', '48', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3674', '20', '49', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3675', '20', '91', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3676', '20', '50', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3677', '20', '92', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3678', '20', '63', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3679', '20', '64', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3680', '20', '65', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3681', '20', '66', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3682', '20', '67', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3683', '20', '68', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3684', '20', '70', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3685', '20', '71', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3686', '20', '72', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3687', '20', '73', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3688', '20', '74', '1497249154');
INSERT INTO `cs_rolemenu` VALUES ('3689', '17', '1', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3690', '17', '69', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3691', '17', '2', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3692', '17', '56', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3693', '17', '57', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3694', '17', '58', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3695', '17', '62', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3696', '17', '80', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3697', '17', '81', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3698', '17', '82', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3699', '17', '83', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3700', '17', '84', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3701', '17', '60', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3702', '17', '61', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3703', '17', '85', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3704', '17', '86', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3705', '17', '59', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3706', '17', '77', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3707', '17', '78', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3708', '17', '79', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3709', '17', '87', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3710', '17', '98', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3711', '17', '99', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3712', '17', '21', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3713', '17', '26', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3714', '17', '24', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3715', '17', '25', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3716', '17', '75', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3717', '17', '76', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3718', '17', '90', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3719', '17', '100', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3720', '17', '51', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3721', '17', '89', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3722', '17', '52', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3723', '17', '88', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3724', '17', '27', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3725', '17', '31', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3726', '17', '29', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3727', '17', '38', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3728', '17', '36', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3729', '17', '37', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3730', '17', '41', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3731', '17', '42', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3732', '17', '43', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3733', '17', '44', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3734', '17', '45', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3735', '17', '46', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3736', '17', '47', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3737', '17', '48', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3738', '17', '49', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3739', '17', '91', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3740', '17', '50', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3741', '17', '92', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3742', '17', '63', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3743', '17', '64', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3744', '17', '65', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3745', '17', '66', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3746', '17', '67', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3747', '17', '68', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3748', '17', '70', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3749', '17', '71', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3750', '17', '72', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3751', '17', '73', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3752', '17', '74', '1497264791');
INSERT INTO `cs_rolemenu` VALUES ('3952', '9', '1', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3953', '9', '69', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3954', '9', '59', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3955', '9', '77', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3956', '9', '78', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3957', '9', '79', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3958', '9', '87', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3959', '9', '98', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3960', '9', '99', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3961', '9', '24', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3962', '9', '25', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3963', '9', '75', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3964', '9', '76', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3965', '9', '90', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3966', '9', '100', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3967', '9', '101', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3968', '9', '51', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3969', '9', '89', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3970', '9', '52', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3971', '9', '88', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3972', '9', '27', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3973', '9', '31', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3974', '9', '29', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3975', '9', '38', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3976', '9', '36', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3977', '9', '37', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3978', '9', '41', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3979', '9', '42', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3980', '9', '43', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3981', '9', '44', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3982', '9', '45', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3983', '9', '97', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3984', '9', '46', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3985', '9', '47', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3986', '9', '93', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3987', '9', '48', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3988', '9', '94', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3989', '9', '49', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3990', '9', '91', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3991', '9', '95', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3992', '9', '50', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3993', '9', '92', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3994', '9', '96', '1497323327');
INSERT INTO `cs_rolemenu` VALUES ('3995', '16', '1', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('3996', '16', '69', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('3997', '16', '2', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('3998', '16', '56', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('3999', '16', '57', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4000', '16', '58', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4001', '16', '62', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4002', '16', '80', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4003', '16', '81', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4004', '16', '82', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4005', '16', '83', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4006', '16', '84', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4007', '16', '60', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4008', '16', '61', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4009', '16', '85', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4010', '16', '86', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4011', '16', '59', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4012', '16', '77', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4013', '16', '78', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4014', '16', '79', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4015', '16', '87', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4016', '16', '98', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4017', '16', '99', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4018', '16', '21', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4019', '16', '26', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4020', '16', '24', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4021', '16', '25', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4022', '16', '75', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4023', '16', '76', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4024', '16', '90', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4025', '16', '100', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4026', '16', '101', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4027', '16', '51', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4028', '16', '89', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4029', '16', '52', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4030', '16', '88', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4031', '16', '27', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4032', '16', '31', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4033', '16', '29', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4034', '16', '38', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4035', '16', '36', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4036', '16', '37', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4037', '16', '41', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4038', '16', '42', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4039', '16', '43', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4040', '16', '44', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4041', '16', '45', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4042', '16', '97', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4043', '16', '46', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4044', '16', '47', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4045', '16', '93', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4046', '16', '48', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4047', '16', '94', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4048', '16', '49', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4049', '16', '91', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4050', '16', '95', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4051', '16', '50', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4052', '16', '92', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4053', '16', '96', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4054', '16', '63', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4055', '16', '64', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4056', '16', '65', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4057', '16', '66', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4058', '16', '67', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4059', '16', '68', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4060', '16', '70', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4061', '16', '71', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4062', '16', '72', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4063', '16', '73', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4064', '16', '74', '1497324085');
INSERT INTO `cs_rolemenu` VALUES ('4278', '1', '1', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4279', '1', '69', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4280', '1', '2', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4281', '1', '56', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4282', '1', '57', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4283', '1', '58', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4284', '1', '62', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4285', '1', '80', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4286', '1', '81', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4287', '1', '82', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4288', '1', '83', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4289', '1', '84', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4290', '1', '60', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4291', '1', '61', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4292', '1', '85', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4293', '1', '86', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4294', '1', '59', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4295', '1', '77', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4296', '1', '78', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4297', '1', '79', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4298', '1', '87', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4299', '1', '98', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4300', '1', '99', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4301', '1', '21', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4302', '1', '26', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4303', '1', '102', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4304', '1', '104', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4305', '1', '103', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4306', '1', '24', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4307', '1', '25', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4308', '1', '75', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4309', '1', '76', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4310', '1', '90', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4311', '1', '100', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4312', '1', '101', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4313', '1', '51', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4314', '1', '89', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4315', '1', '52', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4316', '1', '88', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4317', '1', '27', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4318', '1', '31', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4319', '1', '29', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4320', '1', '38', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4321', '1', '36', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4322', '1', '37', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4323', '1', '41', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4324', '1', '42', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4325', '1', '43', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4326', '1', '44', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4327', '1', '45', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4328', '1', '97', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4329', '1', '46', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4330', '1', '47', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4331', '1', '93', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4332', '1', '48', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4333', '1', '94', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4334', '1', '49', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4335', '1', '91', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4336', '1', '95', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4337', '1', '50', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4338', '1', '92', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4339', '1', '96', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4340', '1', '63', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4341', '1', '64', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4342', '1', '65', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4343', '1', '66', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4344', '1', '67', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4345', '1', '68', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4346', '1', '70', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4347', '1', '71', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4348', '1', '72', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4349', '1', '73', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4350', '1', '74', '1498182684');
INSERT INTO `cs_rolemenu` VALUES ('4494', '2', '1', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4495', '2', '69', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4496', '2', '2', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4497', '2', '56', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4498', '2', '57', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4499', '2', '58', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4500', '2', '62', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4501', '2', '80', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4502', '2', '81', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4503', '2', '82', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4504', '2', '83', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4505', '2', '84', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4506', '2', '60', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4507', '2', '61', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4508', '2', '85', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4509', '2', '86', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4510', '2', '59', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4511', '2', '77', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4512', '2', '78', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4513', '2', '79', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4514', '2', '87', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4515', '2', '98', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4516', '2', '99', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4517', '2', '21', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4518', '2', '26', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4519', '2', '24', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4520', '2', '25', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4521', '2', '75', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4522', '2', '76', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4523', '2', '90', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4524', '2', '100', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4525', '2', '101', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4526', '2', '51', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4527', '2', '89', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4528', '2', '52', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4529', '2', '88', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4530', '2', '27', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4531', '2', '31', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4532', '2', '29', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4533', '2', '38', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4534', '2', '36', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4535', '2', '37', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4536', '2', '41', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4537', '2', '42', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4538', '2', '43', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4539', '2', '44', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4540', '2', '45', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4541', '2', '97', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4542', '2', '46', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4543', '2', '47', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4544', '2', '93', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4545', '2', '48', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4546', '2', '94', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4547', '2', '49', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4548', '2', '91', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4549', '2', '95', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4550', '2', '50', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4551', '2', '92', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4552', '2', '96', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4553', '2', '63', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4554', '2', '64', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4555', '2', '65', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4556', '2', '66', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4557', '2', '67', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4558', '2', '68', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4559', '2', '70', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4560', '2', '71', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4561', '2', '72', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4562', '2', '73', '1499747950');
INSERT INTO `cs_rolemenu` VALUES ('4563', '2', '74', '1499747950');

-- ----------------------------
-- Table structure for cs_user
-- ----------------------------
DROP TABLE IF EXISTS `cs_user`;
CREATE TABLE `cs_user` (
  `user_Id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT '0' COMMENT '组织ID',
  `username` varchar(20) DEFAULT NULL COMMENT '登录账号',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `real_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `head_img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `tel` varchar(20) DEFAULT NULL COMMENT '电话',
  `addtime` varchar(20) DEFAULT NULL COMMENT '添加时间',
  `is_use` int(1) DEFAULT '1' COMMENT '登录许可(0不允许，1允许)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `ser_uid` int(11) DEFAULT '0' COMMENT '关联客服ID',
  `manager_uid` int(11) DEFAULT '0' COMMENT '关联区域经理ID',
  PRIMARY KEY (`user_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='后台管理者表';

-- ----------------------------
-- Records of cs_user
-- ----------------------------
INSERT INTO `cs_user` VALUES ('6', '1', 'admin', 'aaad501a6f8c4d4c4533ba78cdf43b4e', '超级管理员', null, '13975147202', '1490062011', '1', null, null, '0');

-- ----------------------------
-- Table structure for cs_userrole
-- ----------------------------
DROP TABLE IF EXISTS `cs_userrole`;
CREATE TABLE `cs_userrole` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `user_Id` varchar(11) DEFAULT NULL COMMENT '用户ID',
  `role_Id` varchar(11) DEFAULT NULL COMMENT '角色ID',
  `time` varchar(20) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`Id`),
  KEY `user_Id` (`user_Id`),
  KEY `role_Id` (`role_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8 COMMENT='用户角色中间表';

-- ----------------------------
-- Records of cs_userrole
-- ----------------------------
INSERT INTO `cs_userrole` VALUES ('57', '6', '1', '1490593177');
INSERT INTO `cs_userrole` VALUES ('59', '8', '2', '1492072937');
INSERT INTO `cs_userrole` VALUES ('62', '11', '2', '1492393776');
INSERT INTO `cs_userrole` VALUES ('64', '13', '9', '1492497515');
INSERT INTO `cs_userrole` VALUES ('65', '14', '8', '1492498313');
INSERT INTO `cs_userrole` VALUES ('108', '25', '9', '1495867926');
INSERT INTO `cs_userrole` VALUES ('109', '26', '9', '1495867950');
INSERT INTO `cs_userrole` VALUES ('173', '90', '16', '1496278702');
INSERT INTO `cs_userrole` VALUES ('193', '110', '16', '1496304312');
INSERT INTO `cs_userrole` VALUES ('208', '125', '17', '1496313079');
INSERT INTO `cs_userrole` VALUES ('209', '126', '10', '1496313276');
INSERT INTO `cs_userrole` VALUES ('211', '128', '8', '1496322413');
INSERT INTO `cs_userrole` VALUES ('212', '129', '8', '1496322689');
INSERT INTO `cs_userrole` VALUES ('213', '130', '10', '1496369288');
INSERT INTO `cs_userrole` VALUES ('214', '131', '17', '1496369360');
INSERT INTO `cs_userrole` VALUES ('215', '132', '10', '1496369447');
INSERT INTO `cs_userrole` VALUES ('218', '135', '9', '1496370921');
INSERT INTO `cs_userrole` VALUES ('219', '136', '16', '1496371220');
INSERT INTO `cs_userrole` VALUES ('221', '138', '8', '1496375201');
INSERT INTO `cs_userrole` VALUES ('223', '140', '8', '1496387288');
INSERT INTO `cs_userrole` VALUES ('224', '141', '2', '1496387906');
INSERT INTO `cs_userrole` VALUES ('225', '142', '9', '1496392983');
INSERT INTO `cs_userrole` VALUES ('227', '144', '9', '1496625309');
INSERT INTO `cs_userrole` VALUES ('228', '145', '16', '1496625343');
INSERT INTO `cs_userrole` VALUES ('229', '146', '17', '1496625367');
INSERT INTO `cs_userrole` VALUES ('230', '147', '9', '1496626389');
INSERT INTO `cs_userrole` VALUES ('231', '148', '9', '1496626443');
INSERT INTO `cs_userrole` VALUES ('232', '149', '9', '1496626465');
INSERT INTO `cs_userrole` VALUES ('233', '150', '10', '1496626531');
INSERT INTO `cs_userrole` VALUES ('234', '151', '10', '1496626548');
INSERT INTO `cs_userrole` VALUES ('235', '152', '10', '1496626568');
INSERT INTO `cs_userrole` VALUES ('236', '153', '10', '1496626601');
INSERT INTO `cs_userrole` VALUES ('237', '154', '10', '1496626632');
INSERT INTO `cs_userrole` VALUES ('238', '155', '8', '1496630056');
INSERT INTO `cs_userrole` VALUES ('239', '156', '16', '1496634058');
INSERT INTO `cs_userrole` VALUES ('240', '157', '16', '1496634080');
INSERT INTO `cs_userrole` VALUES ('243', '160', '9', '1496649608');
INSERT INTO `cs_userrole` VALUES ('244', '161', '16', '1496651052');
INSERT INTO `cs_userrole` VALUES ('247', '164', '10', '1496663111');
INSERT INTO `cs_userrole` VALUES ('251', '168', '16', '1496735940');
INSERT INTO `cs_userrole` VALUES ('252', '169', '9', '1496735961');
INSERT INTO `cs_userrole` VALUES ('253', '170', '10', '1496735986');
INSERT INTO `cs_userrole` VALUES ('263', '180', '8', '1496803152');
INSERT INTO `cs_userrole` VALUES ('264', '181', '17', '1496803527');
INSERT INTO `cs_userrole` VALUES ('265', '182', '16', '1496826320');
INSERT INTO `cs_userrole` VALUES ('266', '183', '9', '1496826352');
INSERT INTO `cs_userrole` VALUES ('267', '184', '10', '1496826396');
INSERT INTO `cs_userrole` VALUES ('268', '185', '10', '1496826756');
INSERT INTO `cs_userrole` VALUES ('270', '187', '10', '1496885965');
INSERT INTO `cs_userrole` VALUES ('272', '189', '10', '1496886034');
INSERT INTO `cs_userrole` VALUES ('276', '193', '10', '1496908560');
INSERT INTO `cs_userrole` VALUES ('279', '196', '17', '1496972190');
INSERT INTO `cs_userrole` VALUES ('280', '197', '17', '1496972214');
INSERT INTO `cs_userrole` VALUES ('287', '204', '8', '1496977443');
INSERT INTO `cs_userrole` VALUES ('304', '221', '8', '1496990288');
INSERT INTO `cs_userrole` VALUES ('313', '230', '16', '1497006924');
INSERT INTO `cs_userrole` VALUES ('314', '231', '16', '1497229328');
INSERT INTO `cs_userrole` VALUES ('315', '232', '16', '1497248994');
INSERT INTO `cs_userrole` VALUES ('316', '233', '9', '1497249021');
INSERT INTO `cs_userrole` VALUES ('317', '234', '10', '1497249038');
INSERT INTO `cs_userrole` VALUES ('318', '235', '9', '1497249688');
INSERT INTO `cs_userrole` VALUES ('319', '236', '16', '1497249707');
INSERT INTO `cs_userrole` VALUES ('320', '237', '16', '1497320117');
INSERT INTO `cs_userrole` VALUES ('321', '238', '10', '1497322818');
INSERT INTO `cs_userrole` VALUES ('322', '239', '10', '1497929661');
INSERT INTO `cs_userrole` VALUES ('323', '240', '2', '1497929702');
INSERT INTO `cs_userrole` VALUES ('325', '242', '16', '1497946758');
INSERT INTO `cs_userrole` VALUES ('326', '243', '16', '1497947462');
INSERT INTO `cs_userrole` VALUES ('327', '244', '10', '1497947493');
INSERT INTO `cs_userrole` VALUES ('329', '246', '9', '1497947993');

-- ----------------------------
-- Procedure structure for wk
-- ----------------------------
DROP PROCEDURE IF EXISTS `wk`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `wk`()
begin
DECLARE ii,jj INT;
SELECT jj = MAX(id) FROM cs_gift_exchange_record;
set ii = 0;
while ii < 9 do
insert into cs_gift_exchange_record values (jj+1,'1705197amtljzb','1495195948',135,'cp136892',131443,'旅行系列',0,100,1,2,1495195498,0,NULL);
set ii = ii + 1;
end while;
end
;;
DELIMITER ;
