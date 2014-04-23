class IceBreakersController < ApplicationController
  before_action :set_ice_breaker, only: [:show, :edit, :update, :destroy]
  layout 'dashboard_and_profile_layout'

  # GET /ice_breakers
  # GET /ice_breakers.json
  def index
    @ice_breakers = IceBreaker.all
  end

  # GET /ice_breakers/1
  # GET /ice_breakers/1.json
  def show
  end

  # GET /ice_breakers/new
  def new
    @ice_breaker = IceBreaker.new
  end

  # GET /ice_breakers/1/edit
  def edit
  end

  # POST /ice_breakers
  # POST /ice_breakers.json
  def create

    question_count = 0
    @ice_breaker = IceBreaker.create!(:receiver_id=>params[:ice_breaker][:receiver_id],:sender_id=>params[:ice_breaker][:sender_id],:ice_status => true)
    params[:ice_breaker][:questions].each do |q|
    if q[1].to_i == 1
      question_count = question_count+1
      @ice_breaker.questions << Question.find(q[0])
    end
    end

    if question_count > 5 or question_count < 5
    @ice_breaker.destroy!
    redirect_to authenticated_root_path ,:notice=>"Number of Questions...."
    return
    end
    Notification.create!(:content=>"#{current_user.demographic.name} has sent you a ice-breaker", :user_id=>params[:ice_breaker][:receiver_id], :pointer_link=>answer_icebreaker_path(@ice_breaker.id,@ice_breaker.questions.first.id),:sender_id => params[:ice_breaker][:sender_id])


    respond_to do |format|
      if @ice_breaker.save
        format.html { redirect_to user_profile_path(params[:ice_breaker][:receiver_id]), notice: 'Ice breaker was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ice_breaker }
      else
        format.html { render action: 'new' }
        format.json { render json: @ice_breaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ice_breakers/1
  # PATCH/PUT /ice_breakers/1.json
  def update
    respond_to do |format|
      if @ice_breaker.update(ice_breaker_params)
        format.html { redirect_to @ice_breaker, notice: 'Ice breaker was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ice_breaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ice_breakers/1
  # DELETE /ice_breakers/1.json
  def destroy
    @ice_breaker.destroy
    respond_to do |format|
      format.html { redirect_to ice_breakers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ice_breaker
      @ice_breaker = IceBreaker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ice_breaker_params
      params.require(:ice_breaker).permit(:sender_id, :receiver_id, :questions,:ice_status)
      #params[:ice_breaker,:sender_id,:receiver_id,:questions]
    end
end
