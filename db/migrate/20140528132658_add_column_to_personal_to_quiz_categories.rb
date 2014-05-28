class AddColumnToPersonalToQuizCategories < ActiveRecord::Migration
  def change
    add_column :quiz_categories, :personal, :boolean
  end
end
