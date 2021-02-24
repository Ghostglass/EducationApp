class UpdatePostsPosition < ActiveRecord::Migration[6.1]
  def change
    Post.order(:created_at).each.with_index(1) do |post, index|
      post.update_column :position, index
    end
    # default position -> ordered by created date
  end
end
