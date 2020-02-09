const router = require('koa-router')();
const admin = require('./admin.controller');
const post = require('./post.controller');
const category = require('./category.controller');
const laboratory = require('./laboratory.controller');

router.post('/login', admin.login);
router.get('/signOut', admin.signOut);

// 页面路由路由
router.get('/getPostById/:id', post.getPostById);
router.post('/addPost', post.addPost);
router.post('/updatePost/:id', post.updatePost);
router.get('/getPostList', post.getPostList);
router.get('/getPostTotal', post.getPostTotal);
router.put('/offlinePost/:id', post.offlinePost);
router.put('/publishPost/:id', post.publishPost);
router.delete('/deletePost/:id', post.deletePost);

router.get('/getPostsByCatId/:id', category.getPostsByCatId);

// 页面分类路由
router.get('/getCategories', category.getCategories);
router.put('/addNewCategory/:name', category.addNewCategory);
router.put('/updateCategory/:id', category.updateCategory);
router.delete('/deleteCategory/:id', category.deleteCategory);

// 项目路由
router.get('/getLaboratories', laboratory.getLaboratories);
router.post('/createNewLaboratory', laboratory.createNewLaboratory);
router.post('/updateLaboratory', laboratory.updateLaboratory);
router.delete('/deleteLaboratory/:id', laboratory.deleteLaboratory);

module.exports = router;
