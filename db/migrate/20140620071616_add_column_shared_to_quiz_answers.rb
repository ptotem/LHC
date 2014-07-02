class AddColumnSharedToQuizAnswers < ActiveRecord::Migration
  def change
    add_column :quiz_answers, :shared, :boolean ,:default => true
  end
end
