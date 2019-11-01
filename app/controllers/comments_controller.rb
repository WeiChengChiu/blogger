class CommentsController < ApplicationController
	before_action :find_post, only: [:create]

	def create
		if @post == nil || @post.status != 1
			return redirect_to posts_path
		end

		@comment = @post.comments.build(comment_params)

		@comment.save
    redirect_to post_path(@post.id)
	end

	private

	def find_post
		@post = Post.find_by(id: comment_params[:post_id])
	end

	def comment_params
		params.require(:comment).permit(:comment, :post_id)
	end
end
