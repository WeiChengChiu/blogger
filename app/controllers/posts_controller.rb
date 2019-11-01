class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update]
    before_action :find_post, only: [:show, :edit, :update]
    before_action :member_required, only: [:edit, :update]

    def index 
      @publish_posts = Post.published_posts.page(params['page'])
    end

    def author_draft
      @author_draft_posts = Post.draft_posts.author_posts(current_user.id).page(params['page'])
    end
        
    def show    
      # post.status 1 means published post
      @publish_posts_comments = @post.status == 1 ? @post.comments : nil
      @comment = Comment.new
    end

    def new
      @post = Post.new 
    end

    def create
      @post = current_user.posts.build(post_params)
      @post.user_id = current_user.id

      if @post.save
        redirect_to posts_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to posts_path
      else
        render :edit
      end
    end

    private

    def find_post
      @post = Post.find_by(id: params[:id])    
    end

    def post_params
      params.require(:post).permit(:title, :description, :status, :user_id)
    end

    def member_required
      if !current_user.is_member_of?(@post)
        flash[:warning] = "You are not member of this post!" 
        redirect_to post_path(@post)
      end
    end
end
