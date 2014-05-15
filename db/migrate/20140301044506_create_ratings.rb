class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating_scale_id
      t.text :revelation_style
      t.text :expectation_style
      t.integer :value

      t.timestamps
    end
  end
end
