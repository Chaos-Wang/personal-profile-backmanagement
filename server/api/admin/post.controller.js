const moment = require('moment');

exports.getPostById = async(ctx) => {
  let id = ctx.params.id || 0,
    sql = ` SELECT post.id, post.title, post.content, post.poster, post.createTime, 
            post.categoryId, category.name AS categoryName, viewTotal 
            FROM post LEFT JOIN category ON post.categoryId = category.id 
            WHERE post.id = ${id}`;

  try {
    let results = await ctx.execSql(sql);
    if (results.length > 0) {
      ctx.body = {
        success: 1,
        message: '',
        post: results[0]
      };
    } else {
      ctx.body = {
        success: 1,
        message: '',
        post: null
      };
    }
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '查询数据出错'
    };
  }
};

exports.addPost = async(ctx) => {
  let postData = ctx.request.body,
    newPost = {
      title: postData.title,
      content: postData.content,
      categoryId: postData.categoryId,
      viewTotal: 0,
      status: postData.status,
      poster: '',
      createTime: moment().format('YYYY-MM-DD HH:mm:ss')
    };
  try {
    let insert = await ctx.execSql('INSERT INTO post SET ?', newPost);
    if (insert.affectedRows > 0) {
      let id = insert.insertId;

      ctx.body = {
        success: 1,
        id: id
      };
    } else {
      ctx.body = {
        success: 0,
        message: '添加页面出错'
      };
    }
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '添加页面出错'
    };
  }
};

exports.updatePost = async(ctx) => {
  let id = ctx.params.id || 0,
    postData = ctx.request.body,
    newPost = {
      title: postData.title,
      content: postData.content,
      categoryId: postData.categoryId,
      status: postData.status,
      poster: postData.poster
    };
  try {
    let result = await ctx.execSql('UPDATE post SET ? WHERE id = ?', [newPost, id]);
    ctx.body = {
      success: 1
    };
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '添加页面出错'
    };
  }
};

exports.getPostList = async(ctx) => {
  let page = ctx.query.page || 1,
    pageNum = ctx.query.pageNum || 10;
  let pageIndex = (page - 1) * pageNum < 0 ? 0 : (page - 1) * pageNum;
  let sql = ` SELECT post.id, post.title, post.createTime, post.status, post.categoryId, 
                category.name AS categoryName FROM post 
                LEFT JOIN category ON post.categoryId = category.id 
                ORDER BY post.createTime DESC LIMIT ${pageIndex}, ${pageNum}`;
  try {
    let results = await ctx.execSql(sql);
    ctx.body = {
      success: 1,
      message: '',
      posts: results
    };
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '查询数据出错',
      posts: null
    };
  }
};

exports.getPostTotal = async(ctx) => {
  try {
    let results = await ctx.execSql(`SELECT * FROM post`);
    ctx.body = {
      success: 1,
      message: '',
      total: results.length || 0
    };
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '查询数据出错',
      total: 0
    };
  }
};

exports.offlinePost = async(ctx) => {
  let id = ctx.params.id || 0;
  try {
    let results = await ctx.execSql(`UPDATE post SET status = 'OFFLINE' WHERE id = ?`, id);
    ctx.body = {
      success: 1,
      message: ''
    };
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '页面下线出错'
    };
  }
};

exports.publishPost = async(ctx) => {
  let id = ctx.params.id || 0;
  try {
    let results = await ctx.execSql(`UPDATE post SET status = 'PUBLISHED' WHERE id = ?`, id);
    ctx.body = {
      success: 1,
      message: ''
    };
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '页面发布出错'
    };
  }
};

exports.deletePost = async(ctx) => {
  let id = ctx.params.id || 0;
  try {
    let results = await ctx.execSql(`DELETE FROM post WHERE id = ?`, id);
    ctx.body = {
      success: 1,
      message: ''
    };
  } catch (error) {
    console.log(error);
    ctx.body = {
      success: 0,
      message: '页面删除出错'
    };
  }
};
