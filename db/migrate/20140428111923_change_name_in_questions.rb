class ChangeNameInQuestions < ActiveRecord::Migration
  def up
    change_column :questions, :name, :text
  end

  def down
    change_column :questions, :name, :string
  end
end
