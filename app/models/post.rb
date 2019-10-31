class Post < ApplicationRecord
    # status 0: draft, 1: public
    belongs_to :author, class_name: 'User', foreign_key: :user_id

    validates :title, presence: true
    validates :description, presence: true

    scope :index_permit_columns, -> { select(:id, :title, :user_id) }  
    scope :published_posts, -> { index_permit_columns.where(status: 1) } 
    scope :draft_posts, -> { index_permit_columns.where(status: 0) }
    scope :author_posts, ->(user_id) { where(user_id: user_id) }

    def editable_by?(user)
	    user && user == author
	  end
end
