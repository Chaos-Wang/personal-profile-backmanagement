const path = require('path');

module.exports = {
  db: {
    mysql: {
      host: '',
      port:'',
      user: 'root',
      password: '',
      database: 'sites',
      connectionLimit: 10
    },
    redis: {
      port: '',
      host: '',
      db: 0,
      options: {
        return_buffers: false,
        auth_pass: ''
      }
    }
  },
  root: path.normalize(__dirname + '/..'),
  appPath: 'src',
  tempUploads: 'tempUploads',
  uploads: 'uploads',
  port: 9000,
  tokenSecret: 'test',
  isUpdateAdmin: true,
  accessControlAllowOrigin: 'http://localhost:3000',
  adminName: 'admin',
  adminPassword: '123456',
  socketioPath: '/api',
  draftPostRedisKey: 'DRAFTPSOTKEY'
};
