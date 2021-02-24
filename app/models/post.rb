class Post < ApplicationRecord
  belongs_to :course
  has_rich_text :content
  validates_presence_of :course_id, :title, :content
end
