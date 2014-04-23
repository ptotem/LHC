class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  layout 'dashboard_and_profile_layout'

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all
  end

  def welcome_dashboard
    current_user.current_route = my_dashboard_path
    current_user.save!

  end
  
  def my_dashboard
    @user = current_user
    @user_name = current_user.demographic.name

    #render :json => @user.find_matches
    #return

    @current_user_base_match

#es = BaseMatch.where(:user_id=>current_user.id)
#    @current_user_base_matches.each_with_index do |base_match, index|
#      BaseMatch.delete(base_match)
#    end

    #render :json => "nil? :- #{@user.find_matches.nil?}, find_matches :- #{@user.find_matches==[nil]}, [0] :- #{@user.find_matches[0]}"
    #return

    #if !(@user.find_matches.nil? or (@user.find_matches.size == 1 and @user.find_matches[0] == nil))
      #render :text => "Sunny"
      #return
      #@match = BaseMatch.create!(:user_id=>current_user.id, :target_id=>(@user.find_matches["id"]).to_i, :gender_fit=>true, :age_fit=>true, :smoking_fit=>true, :drinking_fit=>true)
      #@match.save!
    #else
      #render :text => "No Match Found..."
      #return
    #end

    @like_requests = Like.where(:receiver_id => current_user.id) rescue nil?
    #if current_user.notifications.blank? and @like_requests.blank?
    #  redirect_to user_profile_path(current_user.id)
    #end
  end

  def user_verification
    @user = current_user
    @user_document = UserDocument.new
    #render :text => params
    #return
  end

  def verify_user_institute_email
    #@user = current_user
    @user = User.find(params[:user][:user_id])
    @user.verification_text = params[:user][:verification_text]
    @user.save!
    redirect_to "/profile/#{@user.id}"
    #render :text => "Successfully updated"
    #return
  end

  def verify_user_linkedin_url
    #@user = current_user
    @user = User.find(params[:user][:user_id])
    @user.verification_text = params[:user][:verification_text]
    @user.save!
    render :text => "Successfully updated"
    return
  end

  #include ApplicationHelper

  def conversations
    #TODO: not done optimally, change as soon as possible
    @user_list =  User.all.map(&:id)
    @conversations = Array.new
    sent_messages = current_user.sent_messages.map(&:receiver_id)
    received_messages = current_user.received_messages.map(&:sender_id)
    @user_list.each do |i|
      if sent_messages.include?(i) or received_messages.include?(i)

        @conversations << {"user"=>i,"message"=> current_user.received_messages.where(:sender_id => i).last.body}
      end
    end
    if @conversations.blank?
      redirect_to user_profile_path(current_user.id), :notice=>"You do not have any conversations"
    end
    #@messages = current_user.sent_messages.where(:receiver_id=>user_list) + current_user.received_messages.where(sender_id:user_list)

    #@conversions = current_user.recipients
    #@receivers = @conversions.map{|i| i.receiver_id}.uniq
    #render :text => @conversions.map{|i| i.receiver_id}.uniq
    #return
  end

  def start_ice_breaker
    @opposite_user = User.find(params[:id])
    @message = Message.new
    @ice_breaker = IceBreaker.new
    #redirect_to conversations_with_users_path(params[:id])
    #@ice=IceBreaker.create( :sender_id => current_user.id, :receiver_id => params[:id])
    #@icequestion=@ice.questions
    #
  end


  def quick_matches
  #if current_user.verified
  #  current_user.update_match
  #  render :text=>current_user.last_matched_time
  #  return
  #  render :text=>(Time.now - current_user.last_matched_time)/3600
    if current_user.last_matched_time.nil? or (Time.now - current_user.last_matched_time)/3600 > 72
      current_user.update_match_status
      current_user.find_matches
      current_user.update_match

      puts "after 3 days"
      #current_user.save!
    end
  #end
    @current_user_quick_matches = BaseMatch.where(:user_id=>current_user.id,:match_status => true)
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
    @target_user = User.find(params[:id])

    @messages = current_user.sent_messages.map{|m|m if m.receiver_id == @target_user.id } + current_user.received_messages.map{|m| m if m.sender_id == @target_user.id }
    @messages.compact!

    if !@messages.blank?
      @messages = @messages.sort{|m1,m2| m1.created_at <=> m2.created_at}
    end
    @messages.reverse!
    #render :text=>@messages
    #return

  end


  def younme

  end

  def answer_icebreaker
    @icebreaker_answer = IcebreakerAnswer.new
    @ice_break=IceBreaker.find(params[:id])
    @question_icebreaker=Question.find(params[:question_id])
  end

  def create_message
    Message.create!(:receiver_id=>params[:receiver_id],:body=>params[:body],:sender_id=>current_user.id)
    Notification.create!(:content=>"#{current_user.demographic.name} has sent you a message", :user_id=>params[:receiver_id], :pointer_link=>conversations_with_users_path(current_user.id),:sender_id => current_user.id)
    redirect_to conversations_with_users_path(params[:receiver_id])
  end

 def under_construction
   render :layout => false
 end


  def invitee_friends
    @emails=params[:email]
    @addresses=@emails.split(',')
    @addresses.each do |invitee|
      InviteeMailer.invitee_email(invitee,current_user.id).deliver
    end
    redirect_to user_profile_path(current_user.id), notice: 'Mail has been successfully sent to your friend.'
  end


  def user_like
    @receiver_id=params[:id]
    @sender_id = current_user.id
    if Like.find_by_receiver_id_and_sender_id(@receiver_id,@sender_id) or Like.find_by_receiver_id_and_sender_id(@sender_id,@receiver_id)
      #render :text => "Request Already Sent"
      #return
      redirect_to my_dashboard_path,:notice=>"Like request already sent !"
      return
    else
      @like=Like.create(:receiver_id => @receiver_id,:sender_id => @sender_id,:status => false)
      #render :text => "Request  Sent"
      #return
      #Notification.create!(:content=>"#{current_user.demographic.name} has sent you a like request.", :user_id=>@receiver_id, :pointer_link=>user_profile_path(current_user.id))
      redirect_to user_profile_path(@receiver_id),:notice=>"Like request sent !"
      return
    end
  end

  def accept_request

   @accept=Like.find(params[:id])
   @accept.status=true
   @accept.save!

   redirect_to user_profile_path(params[:id]), notice: 'You have accepted the request.'
   #return
  end

  def reject_request
    @reject=Like.find(params[:id])
    @reject.status=false
    @reject.save!
    redirect_to user_profile_path(params[:id]), notice: 'You have rejected the request.'
    return
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
