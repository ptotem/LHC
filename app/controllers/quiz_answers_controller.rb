class QuizAnswersController < ApplicationController
  before_action :set_quiz_answer, only: [:show, :edit, :update, :destroy]

  # GET /quiz_answers
  # GET /quiz_answers.json
  def index
    @quiz_answers = QuizAnswer.all
  end

  # GET /quiz_answers/1
  # GET /quiz_answers/1.json
  def show
  end

  # GET /quiz_answers/new
  def new
    @quiz_answer = QuizAnswer.new
  end

  # GET /quiz_answers/1/edit
  def edit
  end

  # POST /quiz_answers
  # POST /quiz_answers.json
  def create
    @quiz_answer = QuizAnswer.new(quiz_answer_params)
    @quiz=Quiz.find(params[:quiz_id])
    @question=Question.find(params[:quiz_answer][:question_id])
    @next_question = (@quiz.questions.map(&:id) - current_user.quiz_answers.map(&:question_id)  - [@question.id])
    if @next_question == []
      redirect_to authenticated_root_path,:alert=>"Successfully given quiz response"
      return
    end
  else
    @next_question = @next_question[0]

    respond_to do |format|
      if @quiz_answer.save
        format.html { redirect_to take_test_path(@quiz.id,@next_question)}
        format.json { render action: 'show', status: :created, location: @quiz_answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @quiz_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quiz_answers/1
  # PATCH/PUT /quiz_answers/1.json
  def update
    respond_to do |format|
      if @quiz_answer.update(quiz_answer_params)
        format.html { redirect_to @quiz_answer, notice: 'Quiz answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quiz_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_answers/1
  # DELETE /quiz_answers/1.json
  def destroy
    @quiz_answer.destroy
    respond_to do |format|
      format.html { redirect_to quiz_answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_answer
      @quiz_answer = QuizAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_answer_params
      params.require(:quiz_answer).permit(:user_id, :question_id, :answer_id)
    end
end
