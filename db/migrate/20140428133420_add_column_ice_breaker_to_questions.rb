class AddColumnIceBreakerToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :ice_breaker, :boolean ,:default => false
  end
end
