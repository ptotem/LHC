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
    #render :json => params[:quiz_answer]
    #return
    @quiz=Quiz.find(params[:quiz_id])


    @quiz_answer = QuizAnswer.new(quiz_answer_params)

    @question=Question.find(params[:quiz_answer][:question_id])
    #render :json => @quiz.questions
    #return

    @next_question = (@quiz.questions.map(&:id) - current_user.quiz_answers.map(&:question_id) - [@question.id])
    #render :json => @quiz.questions
    #return


    respond_to do |format|
      if @quiz_answer.save

        #puts "check next question #{@next_question}"
        if @next_question == []
          current_user.current_route = "/my_dashboard"
          current_user.save!
          #redirect_to snazzmeup_path,:alert=>"Successfully given quiz response"
          redirect_to quiz_review_path(@quiz.id), :alert=>"Successfully given quiz response"
          return
        else
          @next_question = @next_question[0]
          current_user.current_route = "/take_test/#{@quiz.id}/#{@next_question}"
          current_user.save!
        end

        format.html { redirect_to take_test_path(@quiz.id,@next_question)}
        format.json { render action: 'show', status: :created, location: @quiz_answer }

      else
        format.html { redirect_to take_test_path(@quiz.id, @question.id), notice: 'Howdy!! You need to select one option.' }
        format.json { render json: @quiz_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def retest
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_questions = @quiz.questions
    @quiz_questions.each do |quiz_question|
      @user_quiz_ans = QuizAnswer.where(:question_id => quiz_question.id, :user_id => current_user.id).first
      if !@user_quiz_ans.nil?
        #@user_quiz_ans = quiz_question
        @user_quiz_ans.destroy
      end
    end
    redirect_to take_test_path(@quiz.id, @quiz.questions.first.id), notice: 'Take test again.'
    #render :json => @user_quiz_ans.id
    return
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
