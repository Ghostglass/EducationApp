class RemoveCourseFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :course_id
  end
end
