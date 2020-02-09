/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sites` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sites`;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '页面分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='页面分类表';

/*Data for the table `category` */

insert  into `category`(`id`,`name`) values (0,'SideMenu');
insert  into `category`(`id`,`name`) values (1,'专利');
insert  into `category`(`id`,`name`) values (2,'论文');

/*Table structure for table `draft_post_redis` */

DROP TABLE IF EXISTS `draft_post_redis`;

CREATE TABLE `draft_post_redis` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `redisKey` varchar(100) DEFAULT NULL,
  `postId` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `categoryId` int(11) DEFAULT NULL,
  `poster` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `draft_post_redis` */

/*Table structure for table `laboratory` */

DROP TABLE IF EXISTS `laboratory`;

CREATE TABLE `laboratory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '项目名称',
  `description` varchar(1000) DEFAULT NULL COMMENT '项目说明',
  `link` varchar(500) DEFAULT NULL COMMENT '项目地址',
  `poster` varchar(500) DEFAULT NULL COMMENT '项目海报',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='项目表，记录项目';

/*Data for the table `laboratory` */

insert  into `laboratory`(`id`,`name`,`description`,`link`,`poster`,`createTime`) values (1,'示例项目','示例项目介绍。','http://项目官网/','https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1774356743,3337024278&fm=11&gp=0.jpg','2017-12-27 16:37:37');

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL COMMENT '页面标题',
  `content` text COMMENT '页面内容',
  `categoryId` int(11) DEFAULT NULL COMMENT '页面分类表主键',
  `status` enum('DRAFT','PUBLISHED','OFFLINE') DEFAULT NULL COMMENT '页面状态(DRAFT: 草稿， PUBLISHED: 发布，OFFLINE: 下线)',
  `poster` varchar(200) DEFAULT NULL COMMENT '海报图片',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `viewTotal` int(11) DEFAULT NULL COMMENT '页面查看次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='页面表';

/*Data for the table `post` */
insert  into `post`(`id`,`title`,`content`,`categoryId`,`status`,`poster`,`createTime`,`viewTotal`) values (0,'About Me','# 欢迎使用 Markdown\r\n**Markdown是一种轻量级的「标记语言」**\r\n\r\n\r\n![markdown](https://www.mdeditor.com/images/logos/markdown.png \"markdown\")\r\n\r\n\r\nMarkdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。它允许人们使用易读易写的纯文本格式编写文档，然后转换成格式丰富的HTML页面，Markdown文件的后缀名便是“.md”\r\n\r\n\r\n## MdEditor是一个在线编辑Markdown文档的编辑器\r\n\r\n*MdEditor扩展了Markdown的功能（如表格、脚注、内嵌HTML等等），以使让Markdown转换成更多的格式，和更丰富的展示效果，这些功能原初的Markdown尚不具备。*\r\n\r\n> Markdown增强版中比较有名的有Markdown Extra、MultiMarkdown、 Maruku等。这些衍生版本要么基于工具，如~~Pandoc~~，Pandao；要么基于网站，如GitHub和Wikipedia，在语法上基本兼容，但在一些语法和渲染效果上有改动。\r\n\r\nMdEditor源于Pandao的JavaScript开源项目，开源地址[Editor.md](https://github.com/pandao/editor.md \"Editor.md\")，并在MIT开源协议的许可范围内进行了优化，以适应广大用户群体的需求。向优秀的markdown开源编辑器原作者Pandao致敬。\r\n\r\n\r\n![Pandao editor.md](https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png \"Pandao editor.md\")\r\n\r\n\r\n\r\n## MdEditor的功能列表演示\r\n\r\n# 标题H1\r\n\r\n## 标题H2\r\n\r\n### 标题H3\r\n\r\n#### 标题H4\r\n\r\n##### 标题H5\r\n\r\n###### 标题H5\r\n\r\n### 字符效果和横线等\r\n----\r\n\r\n~~删除线~~ <s>删除线（开启识别HTML标签时）</s>\r\n\r\n*斜体字*      _斜体字_\r\n\r\n**粗体**  __粗体__\r\n\r\n***粗斜体*** ___粗斜体___\r\n\r\n上标：X<sub>2</sub>，下标：O<sup>2</sup>\r\n\r\n**缩写(同HTML的abbr标签)**\r\n> 即更长的单词或短语的缩写形式，前提是开启识别HTML标签时，已默认开启\r\n\r\nThe <abbr title=\"Hyper Text Markup Language\">HTML</abbr> specification is maintained by the <abbr title=\"World Wide Web Consortium\">W3C</abbr>.\r\n### 引用 Blockquotes\r\n\r\n> 引用文本 Blockquotes\r\n\r\n引用的行内混合 Blockquotes\r\n\r\n> 引用：如果想要插入空白换行`即<br />标签`，在插入处先键入两个以上的空格然后回车即可，[普通链接](https://www.mdeditor.com/)。\r\n\r\n### 锚点与链接 Links\r\n[普通链接](https://www.mdeditor.com/)\r\n[普通链接带标题](https://www.mdeditor.com/ \"普通链接带标题\")\r\n直接链接：<https://www.mdeditor.com>\r\n[锚点链接][anchor-id]\r\n[anchor-id]: https://www.mdeditor.com/\r\n[mailto:test.test@gmail.com](mailto:test.test@gmail.com)\r\nGFM a-tail link @pandao\r\n邮箱地址自动链接 test.test@gmail.com  www@vip.qq.com\r\n> @pandao\r\n\r\n### End',999,'PUBLISHED','','2017-07-30 12:39:23',21);
insert  into `post`(`id`,`title`,`content`,`categoryId`,`status`,`poster`,`createTime`,`viewTotal`) values (1,'L. Zheng, M. Lops, Y. C. Eldar and X. Wang, "Radar and Communication Co-existence: an Overview", submitted to IEEE Transactions on Signal Processing, February 2019.','https://arxiv.org/pdf/1902.08676.pdf',2,'PUBLISHED','','2017-07-30 12:39:23',21);
insert  into `post`(`id`,`title`,`content`,`categoryId`,`status`,`poster`,`createTime`,`viewTotal`) values (2,'S. Pinilla, T. Bendory, Y. C. Eldar and H. Arguello, "Frequency-Resolved Optical Gating Recovery via Smoothing Gradient", submitted to IEEE Transactions on Signal Processing, February 2019.','https://arxiv.org/pdf/1902.09447.pdf',2,'PUBLISHED','','2017-07-30 12:39:23',21);


DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) DEFAULT NULL COMMENT '用户名',
  `hashedPassword` varchar(1024) DEFAULT NULL COMMENT '加密后的密码',
  `salt` varchar(128) DEFAULT NULL COMMENT '加密的盐',
  `avatar` varchar(500) DEFAULT NULL COMMENT '用户头像',
  `role` enum('ADMIN','GUEST') DEFAULT NULL COMMENT '用户角色（ADMIN:管理员，GUEST:游客）',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `user` */

insert  into `user`(`id`,`userName`,`hashedPassword`,`salt`,`avatar`,`role`,`createTime`) values (41,'admin','F4jEAsk08C9RJ2zpMbwOqDCnJso1SqIYmakqvNRR/nL/z6mXOynAi2+G5YoTRs8OzaFsqgnwUaK6NQWx0oqrOQ==','s3z8t0ZimfJ33ECgI3L1Xw==',NULL,'ADMIN','2018-01-01 18:36:22');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
