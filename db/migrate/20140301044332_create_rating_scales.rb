class CreateRatingScales < ActiveRecord::Migration
  def change
    create_table :rating_scales do |t|
      t.string :name

      t.timestamps
    end
  end
end
