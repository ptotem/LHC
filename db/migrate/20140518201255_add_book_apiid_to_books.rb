class AddBookApiidToBooks < ActiveRecord::Migration
  def change
    add_column :books, :book_api_id, :integer
  end
end
