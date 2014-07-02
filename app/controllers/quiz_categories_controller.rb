class QuizCategoriesController < ApplicationController
  before_action :set_quiz_category, only: [:show, :edit, :update, :destroy]

  #layout "dashboard_and_profile_layout"
  layout :resolve_layout

  def resolve_layout
    puts "action_name :- #{action_name}"
    puts "device_type :- #{device_type}"
    #if action_name == "start_test" || action_name == "take_test"
    if device_type == :desktop
      "dashboard_and_profile_layout"
    #elsif action_name == "start_test_mobile" || action_name == "take_test_mobile"
    elsif device_type == :mobile
      "dashboard_and_profile_layout_mobile"
    end
  end

  # GET /quiz_categories
  # GET /quiz_categories.json
  def index
    @quiz_categories = QuizCategory.all
  end

  # GET /quiz_categories/1
  # GET /quiz_categories/1.json
  def show
  end

  # GET /quiz_categories/new
  def new
    @quiz_category = QuizCategory.new
  end

  # GET /quiz_categories/1/edit
  def edit
  end

  # POST /quiz_categories
  # POST /quiz_categories.json
  def create
    @quiz_category = QuizCategory.new(quiz_category_params)

    respond_to do |format|
      if @quiz_category.save
        format.html { redirect_to @quiz_category, notice: 'Quiz category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quiz_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @quiz_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quiz_categories/1
  # PATCH/PUT /quiz_categories/1.json
  def update
    respond_to do |format|
      if @quiz_category.update(quiz_category_params)
        format.html { redirect_to @quiz_category, notice: 'Quiz category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quiz_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_categories/1
  # DELETE /quiz_categories/1.json
  def destroy
    @quiz_category.destroy
    respond_to do |format|
      format.html { redirect_to quiz_categories_url }
      format.json { head :no_content }
    end
  end


  def start_test
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to start_test_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @test=QuizCategory.find(params[:id])
    end
  end

  def start_test_mobile
    @test=QuizCategory.find(params[:id])
  end

  def take_test
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to take_test_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @quiz_answer = QuizAnswer.new
      @quiz=Quiz.find(params[:id])
      @total_questions = @quiz.questions.map(&:id).count
      @current_question_index = @quiz.questions.map(&:id)
      @question=Question.find(params[:question_id])
      @next_question = (@quiz.questions - [@question])[0]
    end
  end

  def take_test_mobile
    #render :text => "here is take_test_mobile"
    #return
    @quiz_answer = QuizAnswer.new
    @quiz=Quiz.find(params[:id])
    @total_questions = @quiz.questions.map(&:id).count
    @current_question_index = @quiz.questions.map(&:id)
    @question=Question.find(params[:question_id])
    @next_question = (@quiz.questions - [@question])[0]
  end

  def user_answer

    render :text =>params
    return
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_category
      @quiz_category = QuizCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_category_params
      params.require(:quiz_category).permit(:name, :intro, :status)
    end
end
