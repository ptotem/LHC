class AddColumnScoreToOptions < ActiveRecord::Migration
  def change
    add_column :options, :score, :integer
  end
end
