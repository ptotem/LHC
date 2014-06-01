class IcebreakerAnswersController < ApplicationController
  before_action :set_icebreaker_answer, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper
  # GET /icebreaker_answers
  # GET /icebreaker_answers.json
  def index
    @icebreaker_answers = IcebreakerAnswer.all
  end

  # GET /icebreaker_answers/1
  # GET /icebreaker_answers/1.json
  def show
  end

  # GET /icebreaker_answers/new
  def new
    @icebreaker_answer = IcebreakerAnswer.new
  end

  # GET /icebreaker_answers/1/edit
  def edit
  end

  # POST /icebreaker_answers
  # POST /icebreaker_answers.json
  def create

    @icebreaker_answer = IcebreakerAnswer.new(icebreaker_answer_params)
    @ice=IceBreaker.find(params[:icebreaker_answer][:ice_breaker_id])
    @question=Question.find(params[:icebreaker_answer][:question_id])
    @next_question = (@ice.questions.map(&:id) - @ice.icebreaker_answers.map(&:question_id)  - [@question.id])
    @icebreaker_answer.ice_ans_status=true
    #@ice.icebreaker_answers.each do |s|
    #  s.ice_ans_status=true
    #  s.save!
    #end


    #render :json =>  @next_question
    #return
    respond_to do |format|
      if @icebreaker_answer.save!
        if @next_question == []
          if !check_icebreaker_status(@ice.sender_id)
            redirect_to start_ice_breaker_path(@ice.sender_id), :notice=>"Now its your turn to send an Ice-breaker."
          else
            redirect_to user_profile_path(@ice.receiver_id), :notice=>"Now Start the conversations"
          end

          #format.html { redirect_to authenticated_root_path, notice: 'Now its your turn to send an Ice-breaker.' }
          return
        else
          @next_question = @next_question[0]
        end


        format.html { redirect_to answer_icebreaker_path(@ice.id,@next_question), notice: 'Icebreaker answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @icebreaker_answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @icebreaker_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /icebreaker_answers/1
  # PATCH/PUT /icebreaker_answers/1.json
  def update
    respond_to do |format|
      if @icebreaker_answer.update(icebreaker_answer_params)
        format.html { redirect_to @icebreaker_answer, notice: 'Icebreaker answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @icebreaker_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /icebreaker_answers/1
  # DELETE /icebreaker_answers/1.json
  def destroy
    @icebreaker_answer.destroy
    respond_to do |format|
      format.html { redirect_to icebreaker_answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_icebreaker_answer
      @icebreaker_answer = IcebreakerAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def icebreaker_answer_params
      params.require(:icebreaker_answer).permit(:ice_breaker_id, :question_id, :user_id, :answer_id,:ice_ans_status)
    end
end
