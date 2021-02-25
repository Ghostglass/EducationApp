class Post < ApplicationRecord
  belongs_to :course
  has_rich_text :content
  validates_presence_of :course_id, :title, :content

  has_many :comments, dependent: :destroy


  before_create :set_position	

  private

  def set_position	
    last_max_position = Post.where(course_id: self.course_id).maximum("position")	
    self.position ||= last_max_position.to_i + 1	
  end
end
