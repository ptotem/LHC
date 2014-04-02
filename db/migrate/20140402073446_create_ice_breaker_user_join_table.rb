class CreateIceBreakerUserJoinTable < ActiveRecord::Migration
  def change
    create_join_table :ice_breakers, :users do |t|
      # t.index [:ice_breaker_id, :user_id]
      # t.index [:user_id, :ice_breaker_id]
    end
  end
end
