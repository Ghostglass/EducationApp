class AddForeignKeysToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :course, foreign_key: true
    add_reference :comments, :post, foreign_key: true
  end
end
