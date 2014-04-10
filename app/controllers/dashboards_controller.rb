class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  layout 'dashboard_and_profile_layout'

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all
  end

  def welcome_dashboard

  end
  
  def my_dashboard
    @user = current_user
    @user_name = current_user.demographic.name

    #render :json => @user.find_matches
    #return

    @current_user_base_matches = BaseMatch.where(:user_id=>current_user.id)
    @current_user_base_matches.each_with_index do |base_match, index|
      BaseMatch.delete(base_match)
    end

    #render :json => "nil? :- #{@user.find_matches.nil?}, find_matches :- #{@user.find_matches==[nil]}, [0] :- #{@user.find_matches[0]}"
    #return

    if !(@user.find_matches.nil? or (@user.find_matches.size == 1 and @user.find_matches[0] == nil))
      #render :text => "Sunny"
      #return
      #@match = BaseMatch.create!(:user_id=>current_user.id, :target_id=>(@user.find_matches["id"]).to_i, :gender_fit=>true, :age_fit=>true, :smoking_fit=>true, :drinking_fit=>true)
      #@match.save!
    else
      #render :text => "No Match Found..."
      #return
    end

  end

  def user_verification
    #render :text => params
    #return
  end

  def conversations
    @conversions = current_user.recipients
    @receivers = @conversions.map{|i| i.receiver_id}.uniq
    #render :text => @conversions.map{|i| i.receiver_id}.uniq
    #return
  end

  def start_ice_breaker
    @opposite_user = User.find(params[:id])

    @message = Message.new
  end


  def quick_matches
    @current_user_quick_matches = BaseMatch.where(:user_id=>current_user.id)
    #render :json => @current_user_quick_matches
    #return
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dashboard }
      else
        format.html { render action: 'new' }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url }
      format.json { head :no_content }
    end
  end

 def mutual_likes


 end
 def snazzmeup

 end
  def conversations_with_users

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params[:dashboard]
    end


end
