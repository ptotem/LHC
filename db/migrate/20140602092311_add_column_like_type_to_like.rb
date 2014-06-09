class AddColumnLikeTypeToLike < ActiveRecord::Migration
  def change
    add_column :likes, :like_type, :string
  end
end
