class AddColumnIceAnsStatusToIcebreakerAnswers < ActiveRecord::Migration
  def change
    add_column :icebreaker_answers, :ice_ans_status, :boolean , :default => false
  end
end
