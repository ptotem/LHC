class Quiz < ActiveRecord::Base
  belongs_to :quiz_category
  has_and_belongs_to_many :questions
  has_many :quiz_results

  def calculate_total_score_for(user_id)
    user  = User.find(user_id)
    questions = self.questions
    total_score = 0
    answers = user.quiz_answers.where(:question_id=>questions.map(&:id))
    answers.each do |a|
      total_score = total_score + Option.find(a.answer_id).score
    end
    puts "total_score :- #{total_score}"
    total_score
  end

end
