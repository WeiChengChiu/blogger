module PostsHelper
  def render_posts_button
    link_to("Home", posts_path, class: "btn btn-mini btn-primary pull-right")
  end

	def render_post_new_button
		link_to("New post", new_post_path, class: "btn btn-mini btn-primary pull-right")
	end

	def render_post_title(post)
    truncate(post.title, length: 15)
  end

	def render_post_button(post)
		link_to(render_post_title(post), post_path(post.id))
	end

	def render_post_edit_button(post)
    if current_user && post.editable_by?(current_user)
      link_to("Edit", edit_post_path(post))
    else
    	"Only the author can edit"
    end
  end

  def render_author_draft_posts_button
  	if current_user
  		link_to("Draft posts", author_draft_posts_path)	
  	end
  end
end
