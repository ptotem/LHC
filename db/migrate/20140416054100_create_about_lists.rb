class CreateAboutLists < ActiveRecord::Migration
  def change
    create_table :about_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
