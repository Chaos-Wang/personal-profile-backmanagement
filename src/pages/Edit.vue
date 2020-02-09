<template>
  <section class="edit right-container">
    <back-menu></back-menu>
    <back-header></back-header>
    <form class="post-form">
      <div class="form-group col-12">
        <input type="text" class="title" v-model="post.title" placeholder="页面标题">
      </div>
      <div class="form-group col-12 no-overflow">
        <db-select class="category"
                   :selected="post.categoryId"
                   :options="categories"
                   @selected-value="changeSelectedCategory"></db-select>
        <button class="btn-default add-category" @click="addCategory">添加分类</button>
      </div>
      <div class="form-group col-12">
        <db-markdown :content="post.content" @sync-content="syncContent"></db-markdown>
      </div>
    </form>
    <div class="btn-group">
      <button class="btn-default btn-primary" @click="publishPost">发布页面</button>
      <button class="btn-default" @click="draftPost">保存草稿</button>
    </div>
  </section>
</template>

<script>
  import api from '../fetch/api';
  import Menu from '../components/Menu';
  import Header from '../components/Header';
  import DBMarkdown from '../components/DB-Markdown';
  import DBSelect from '../components/DB-Select';

  export default {
    components: {
      'back-menu': Menu,
      'back-header': Header,
      'db-markdown': DBMarkdown,
      'db-select': DBSelect
    },
    data () {
      return {
        post: {
          title: '',
          content: '',
          categoryId: 0,
          status: ''
        },
        categories: [{
          id: 0,
          name: '请选择页面分类'
        }],
        isFirtUpdatePostChange: false,  // 编辑时第一次获取到post对象时不使用websocket保存
        isLoading: false
      };
    },
    watch: {
      $route: function () {
        if (this.$route.params.id) {
          this.getPostById(this.$route.params.id);
        } else {
          this.post = {
            title: '',
            content: '',
            categoryId: 0,
            status: ''
          };
        }
      },
      post: {
        handler: function (val, oldVal) {
          if (this.isFirtUpdatePostChange) {
            this.isFirtUpdatePostChange = false;
          } else {
            let newPost = this.createSavePost();
            this.$socket.emit('saveDraftPost', newPost);
          }
        },
        deep: true
      }
    },
    sockets: {
      connect: function () {
        console.log('socket connected');
      },
      getDraftPost: function (val) {
        if (val) {
          // let serverPost = JSON.parse(val);
          Object.assign(this.post, val);
        }
      }
    },
    created () {
      this.getCategories();
      if (this.$route.params.id) {
        this.getPostById(this.$route.params.id);
      } else {
        this.getDraftPost();
      }
    },
    methods: {
      syncContent: function (content) {
        this.post.content = content;
      },
      changeSelectedCategory: function (catId) {
        console.log(catId);
        this.post.categoryId = catId;
        console.log(this.post);
      },
      getPostById: async function (id) {
        let res = await api.getPostById(id);
        if (res.success === 1) {
          this.isFirtUpdatePostChange = true;
          this.post = res.post;
        }
      },
      getCategories: async function () {
        let res = await api.getCategories();
        if (res.success === 1) {
          let categories = res.categories;
          categories.unshift({
            id: 0,
            name: '请选择页面分类'
          });
          this.categories = categories;
        }
      },
      publishPost: async function () {
        if (this.isLoading) {
          return;
        }
        this.isLoading = true;
        this.post.status = 'PUBLISHED';
        let newPost = Object.assign({}, this.post);
        let res = null;
        if (this.$route.params.id) {
          res = await api.updatePost(this.$route.params.id, newPost);
        } else {
          res = await api.addPost(newPost);
        }
        if (res.success === 1) {
          this.$socket.emit('clearDraftPost');
          this.$message.showMessage({
            type: 'success',
            content: '页面发布成功'
          });
          this.$router.push({ path: '/postlist' });
        }
        this.isLoading = false;
      },
      draftPost: async function () {
        if (this.isLoading) {
          return;
        }
        this.isLoading = true;
        this.post.status = 'DRAFT';
        let newPost = this.createSavePost();
        let res = null;
        if (this.$route.params.id) {
          res = await api.updatePost(this.$route.params.id, newPost);
        } else {
          res = await api.addPost(newPost);
        }
        if (res.success === 1) {
          this.$socket.emit('clearDraftPost');
          this.$message.showMessage({
            type: 'success',
            content: '页面保存草稿成功'
          });
          this.$router.push({ path: '/postlist' });
        }
        this.isLoading = false;
      },

      addCategory: function () {
        this.$msgBox.showMsgBox({
          title: '添加分类',
          content: '请填写分类名称',
          isShowInput: true
        }).then(async (val) => {
          let res = await api.addNewCategory(val);
          if (res.success === 1) {
            this.categories.push({
              id: res.newId,
              name: val
            });
            this.$message.showMessage({
              type: 'success',
              content: '添加分类成功'
            });
          } else {
            this.$message.showMessage({
              type: 'error',
              content: res.message
            });
          }
        }).catch(() => {
          console.log('cancel');
        });
      },
      getDraftPost: function () {
        this.$socket.emit('getDraftPost');
      },
      createSavePost: function () {
        let savePost = {
          id: this.post.id || 0,
          title: this.post.title,
          content: this.post.content,
          categoryId: this.post.categoryId,
          status: this.post.status,
          poster: this.post.poster
        };
        return savePost;
      }
    }
  };
</script>

<style lang="scss" scoped>
  @import '../assets/sass/app';
  .edit {
    position: relative;

    .post-form {
      margin: 0 -1em 5em;

      .no-overflow {
        overflow: visible;
      }
      .category {
        width: calc(100% - 9em);
      }
      .add-category {
        position: absolute;
        top: 0.15em;
        right: 0.7em;
      }
    }

    .btn-group {
      position: fixed;
      bottom: 0;
      left: 0;
      right: 0;
      background: #fff;
      z-index: 999;
      padding: 1em 0;
      button {
        float: right;
        margin-right: 1em;
      }
    }
  }
</style>
