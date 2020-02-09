### 目录结构
+blog-backManage                                    -后台管理
        +build                                              -webpack等打包用组件
            -...
        +config                                             -配置
            -...
        +src                                                -后台管理页面
            +assets                                         -sass
                -...
            +components                                     -组件
                -...
            +fetch                                          -与后端交互的API
                -...
            +pages                                          -后台管理页面
                -...
            +router                                         -页面路由
                -...
            -...
        +static                                             -静态资源
            -...
        +server                                             -服务端
            +api                                            -api
                -...
            +util                                           -组件
                -...
            +config
                +enviroment                                 -环境变量
                    -...
                +src                                        -测试上传功能
                    -...
                -koa.js
            +middlreware                                    -中间件
                -tokenError.js                              -使用token的身份验证
            +routes                                         -地址解析与api路由
                -indes.js
            -app.js                                         -服务入口
        -blog.sql                                           -mysql数据库
        
### 技术选型与环境要求
    -管理页面：
 	    -vue.js
    -后台：
 	    -koa.js
 	    -mysql
 	    -redis
### 部署指南
    1. 克隆本项目；
    2. cd到根目录下；
    3. 参考blog.sh创建数据库；
    4. 修改./server/config/enviroment/development.js中的相关信息；
    5. 在根目录执行 npm install；
    6. 执行 npm run dev(开发模式)或npm run build(上线部署)
    7. 执行 node ./server/app.js

### 项目地址
    后台管理：localhost:8081
    服务端API：localhost:9000
 
### Tips
    后台预设置密码账户: admin(123456)
    
