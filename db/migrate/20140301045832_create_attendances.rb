class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :institution_id
      t.date :year_from
      t.date :year_to
      t.string :office

      t.timestamps
    end
  end
end
