class CreateUserPersonalityJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :personalities do |t|
      # t.index [:user_id, :personality_id]
      # t.index [:personality_id, :user_id]
    end
  end
end
