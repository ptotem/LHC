class CreateCriterions < ActiveRecord::Migration
  def change
    create_table :criterions do |t|
      t.integer :user_id
      t.boolean :male
      t.integer :minage
      t.integer :maxage
      t.string :smoking
      t.string :drinking

      t.timestamps
    end
  end
end
