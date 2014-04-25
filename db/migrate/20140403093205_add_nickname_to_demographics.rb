class AddNicknameToDemographics < ActiveRecord::Migration
  def change
    add_column :demographics, :nickname, :string
  end
end
