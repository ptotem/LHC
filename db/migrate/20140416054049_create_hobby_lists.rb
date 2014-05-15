class CreateHobbyLists < ActiveRecord::Migration
  def change
    create_table :hobby_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
