class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  layout 'dashboard_and_profile_layout'
  include ApplicationHelper

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all
  end

  def welcome_dashboard
    @current_user_route = current_user.current_route
    #current_user.current_route = my_dashboard_path
    current_user.save!
    if current_user.last_matched_time.nil? or (Time.now - current_user.last_matched_time)/3600 > 72
      current_user.update_match_status
      current_user.find_matches
      current_user.update_match
      end


    end
  
  def my_dashboard
    @user = current_user
    @user_name = current_user.demographic.name

    @user_first_visit = @user.first_visit
    @user.first_visit = true
    @user.save!
    if current_user.last_matched_time.nil? or (Time.now - current_user.last_matched_time)/3600 > 72
      current_user.update_match_status
      current_user.find_matches
      current_user.update_match
    end

    #render :text => @user.first_visit
    #return

    @user.notifications.each do |n|
      n.notification_seen = true
      n.save!

      if ((((3.days.since(n.created_at) - Time.now)/3600).to_i ) <= 0)
        n.destroy
      end
    end

    @like_requests = Like.where(:receiver_id => current_user.id,:status=>false) rescue nil?


    Like.where(:receiver_id => current_user.id).each do |e|
     if ((((3.days.since(e.created_at) - Time.now)/3600).to_i ) <= 0)
        e.destroy
     end
    end

    #render :json => @like_requests
    #return


    # TODO: Why was this code commented ? I wrote it for a reason- Rushabh
    if current_user.notifications.blank? and @like_requests.blank?
      #redirect_to user_profile_path(current_user.id),:notice => "You have no notifications"
      redirect_to welcome_dashboard_path,notice: "You do not have any notifications."
    end
  end

  def user_verification
    @user = current_user
    if current_user.verification_request_sent
      redirect_to user_profile_path(current_user.id),notice:"Verification request sent, please wait while the admin verifies your account!"
      return
    end
    @user_document = UserDocument.new
    #render :text => params
    #return
  end

  def verify_user_institute_email
    #@user = current_user
    @user = User.find(params[:user][:user_id])
    @user.verification_text = params[:user][:verification_text]
    @user.verification_request_sent_at = Time.now.to_i
    @user.institutional_mail = Devise.friendly_token
    @user.save!
    extracted_email= @user.verification_text.split("@").last
    domain_array=DomainName.all.map(&:name)
    if domain_array.any?{|s| s.include?(extracted_email)}
      @inst= DomainName.where(:name => extracted_email).first
      if @inst.institute_name == Institution.find(@user.demographic.last_institute).name
      @user.verification_request_sent = true
      @user.save!
      VerMailer.ver_email(@user.verification_text,@user).deliver
        redirect_to user_profile_path(current_user.id),:notice => "An email has been sent for verification."
      else
        redirect_to user_verification_path,:notice => "Please enter a valid institute email id"
      end
    else
      @user.verification_request_sent = false
      @user.save!
      redirect_to user_verification_path,:notice => "Please enter a valid institute email id"
    end
  end

  def start_verify_user_institute_email
    @user = User.find(params[:user_id])
    if @user.institutional_mail == params[:token]
      @user.verified = true
      @user.save!
      redirect_to user_profile_path(@user.id),:notice => "Your academic credentials have been verified."
    end
  end


  def verify_user_linkedin_url
    #@user = current_user
    @user = User.find(params[:user][:user_id])
    @user.verification_text = params[:user][:verification_text]
    @user.verification_request_sent = true
    @user.verification_request_sent_at = Time.now.to_i
    @user.save!
    redirect_to user_profile_path(current_user.id),:notice => "Great! You will be verified pretty soon. "
    return
  end

  def upload_user_doc
    @user = User.find(params[:user][:user_id])

    render :text => params
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

        @conversations << {"user"=>i,"message"=> current_user.received_messages.where(:sender_id => i).last.body, "time"=>current_user.received_messages.where(:sender_id => i).last.created_at}
      end
    end
    # if @conversations.blank?
    #   #redirect_to user_profile_path(current_user.id), :notice=>"You do not have any conversations"
    #   redirect_to my_dashboard_path, :notice=>"You do not have any conversations."
    # end
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

    #render :text=>current_user.last_matched_time
    #render :text=>(Time.now - current_user.last_matched_time)/3600
    #return

    if current_user.last_matched_time.nil? or (Time.now - current_user.last_matched_time)/3600 > 72
      current_user.update_match_status
      current_user.find_matches
      current_user.update_match

      #puts "after 3 days"
      #current_user.save!
      #render :text => "after 3 days"
      #return
    end
  #end

    @current_user_quick_matches = BaseMatch.where(:user_id=>current_user.id,:match_status => true)

    @mutual_likes =Array.new
    User.all.each do |u|
      if !get_like_status(u.id).nil?
        @mutual_likes << u
      end

      # if (Like.where(:sender_id => current_user.id, :receiver_id => ubm).first and Like.where(:sender_id => ubm, :receiver_id => current_user.id).first.status) or (Like.where(:sender_id => ubm, :receiver_id => current_user.id).first and Like.where(:sender_id => current_user.id, :receiver_id => ubm).first.status)
      #   @mutual_likes << User.find(ubm)
      #MindMatch.create(:user_id=>current_user.id, :target_id=>@mutual_likes.id)
      # end
    end
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


   @current_user_quick_matches = BaseMatch.where(:user_id=>current_user.id,:match_status => true)
   @user_base_matches = BaseMatch.where(:user_id=>current_user.id).map{|i| i.target_id}

   @mutual_likes =Array.new
   User.all.each do |u|
     if !get_like_status(u.id).nil?
       @mutual_likes << u
     end

     # if (Like.where(:sender_id => current_user.id, :receiver_id => ubm).first and Like.where(:sender_id => ubm, :receiver_id => current_user.id).first.status) or (Like.where(:sender_id => ubm, :receiver_id => current_user.id).first and Like.where(:sender_id => current_user.id, :receiver_id => ubm).first.status)
     #   @mutual_likes << User.find(ubm)
       #MindMatch.create(:user_id=>current_user.id, :target_id=>@mutual_likes.id)
     # end
   end
   # @mutual_likes = []

  # render :text=>@mutual_likes
  # return
   #render :json=>@mutual_likes
   #return


 end


 def snazzmeup
   #render :text => current_user.current_route
   #return
   if current_user.current_route.include?("take_test")
     redirect_to current_user.current_route, notice: 'Answer the questions first.'
     #render :text => "CT"
     #return
   #else
   #  redirect_to current_user.current_route
   end
 end


  def conversations_with_users

    @target_user = User.find(params[:id])


    #render :text => !RejectedMatch.where(:rejected_target=>@target_user, :user_id=>current_user.id).first.nil?
    #return

    if RejectedMatch.where(:rejected_target=>@target_user, :user_id=>current_user.id).first.nil?
      @messages = current_user.sent_messages.map{|m|m if m.receiver_id == @target_user.id } + current_user.received_messages.map{|m| m if m.sender_id == @target_user.id }
      @messages.compact!

      if !@messages.blank?
        @messages = @messages.sort{|m1,m2| m1.created_at <=> m2.created_at}
      end
      @messages.reverse!
      #render :text=>@messages
      #return
    else
      redirect_to user_profile_path(current_user.id), notice: 'You have blocked the user.'
    end



  end

  def quiz_review
    @quiz = Quiz.find(params[:quiz_id])
    @user = current_user
    #render :json => @user
    #return
  end

  def younme
    @opposite_user = User.find(params[:id])

    #Sunny's code starts
    @current_user_quiz = current_user.quiz_answers
    @opposite_user_quiz = User.find(params[:id]).quiz_answers
    @common_questions = @current_user_quiz - @opposite_user_quiz
    @my_ans = @current_user_quiz.map{|i| i.answer_id}
    @opp_ans = @opposite_user_quiz.map{|i| i.answer_id}
    #@diff_answer =
    #render :json => @common_questions
    #render :json => QuizAnswer.where("user_id = ? OR user_id = ?",current_user.id, params[:id])
    #return
    #Sunny's code ends

    #Nilesh' code starts
    @current_user_quiz_quests = Array.new
    current_user.quiz_answers.each do |cu_qa|
      @current_user_quiz_quests << cu_qa.question_id
    end

    @current_user_quiz_ans = Array.new
    current_user.quiz_answers.each do |cu_qa_ans|
      @current_user_quiz_ans << cu_qa_ans.answer_id
    end

    @opposite_user_quiz_quests = Array.new
    @opposite_user.quiz_answers.each do |ou_qa|
      @opposite_user_quiz_quests << ou_qa.question_id
    end

    @opposite_user_quiz_ans = Array.new
    @opposite_user.quiz_answers.each do |ou_qa_ans|
      @opposite_user_quiz_ans << ou_qa_ans.answer_id
    end

    #@current_user_quiz_quests
    #@opposite_user_quiz_quests

    @both_users_quiz_quests_same = Array.new
    @both_users_quiz_quests_same = @current_user_quiz_quests & @opposite_user_quiz_quests
    #@both_users_quiz_quests_same

    #@current_user_quiz_ans
    #@opposite_user_quiz_ans

    @both_users_quiz_ans_same = Array.new
    @both_users_quiz_ans_same = @current_user_quiz_ans & @opposite_user_quiz_ans
    #@both_users_quiz_ans_same
    @current_user_diff_ans = @current_user_quiz_ans - @both_users_quiz_ans_same
    @opposite_user_diff_ans = @opposite_user_quiz_ans - @both_users_quiz_ans_same
    #Nilesh' code ends

    @current_user_q_name = Array.new
    @current_user_ans_name = Array.new
    @current_user_diff_ans.each do |cuda|
      @current_user_q_name << Option.find(cuda).question.name
      @current_user_ans_name << Option.find(cuda).name
    end

    @opposite_user_q_name = Array.new
    @opposite_user_ans_name = Array.new
    @opposite_user_diff_ans.each do |ouda|
      @opposite_user_q_name << Option.find(ouda).question.name
      @opposite_user_ans_name << Option.find(ouda).name
    end

    @user_quizzes = Array.new
    @uquizzes = Array.new
    @user_quiz_ans_questions = @opposite_user.quiz_answers.where(:shared=>true).map(&:question_id)

    @user_quiz_ans_questions.each do |q|
      if Question.find(q).quizzes.first.quiz_category.personal
        @user_quizzes << Question.find(q).quizzes.first
      end
      #@user_quizzes << q.quizzes.map(&:name)
    end
    @user_quizzes = @user_quizzes.uniq
    @user_quizzes.each do |i|
      @uquizzes << Quiz.find(i)
    end
    #render :json =>@uquizzes
    #return
   @quizzes = QuizCategory.where(:personal => true).first.quizzes rescue []
   #render :json => @quizzes
   #return



  end

  def answer_icebreaker
    @icebreaker_answer = IcebreakerAnswer.new
    @ice_break=IceBreaker.find(params[:id])
    @question_icebreaker=Question.find(params[:question_id])
    @total_questions = @ice_break.questions.count
    @current_question_index = @ice_break.questions.map(&:id).index(@question_icebreaker.id) + 1
    #render :text => @current_question_index
    #return

  end

  def create_message
    Message.create!(:receiver_id=>params[:receiver_id],:body=>params[:body],:sender_id=>current_user.id)
    Notification.create!(:content=>"#{current_user.demographic.nickname} has sent you a message", :user_id=>params[:receiver_id], :pointer_link=>conversations_with_users_path(current_user.id),:sender_id => current_user.id)
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
    # render :json=> params
    # return
    @receiver_id=params[:id]
    @sender_id = current_user.id
    if Like.find_by_receiver_id_and_sender_id(@receiver_id,@sender_id) or Like.find_by_receiver_id_and_sender_id(@sender_id,@receiver_id)
      #render :text => "Request Already Sent"
      #return
      #redirect_to my_dashboard_path,:notice=>"Like request already sent !"
      redirect_to user_profile_path(@receiver_id),:notice=>"Already liked. Stay Cool!!"
      return
    else
      @like=Like.create(:receiver_id => @receiver_id,:sender_id => @sender_id,:status => false,:like_type => "Timed")
      Notification.create!(:content=>"You have liked "+User.find(@receiver_id).demographic.nickname, :user_id=>current_user.id, :pointer_link=>user_profile_path(@receiver_id),:sender_id => @receiver_id,:notification_type=>"Timed")
      #render :text => "Request  Sent"
      #return
      #Notification.create!(:content=>"#{current_user.demographic.name} has sent you a like request.", :user_id=>@receiver_id, :pointer_link=>user_profile_path(current_user.id))
      redirect_to user_profile_path(@receiver_id),:notice=>"Cool! Now let's see wait and watch"
      return
    end
  end

  def accept_request

   @accept=Like.find(params[:id])
   @accept.status=true
   @accept.save!

   redirect_to user_profile_path(@accept.sender_id), notice: 'Great! You two like each other.'
   Notification.create!(:content=>User.find(@accept.receiver_id).demographic.nickname + " likes you too !", :user_id=>@accept.sender_id, :pointer_link=>user_profile_path(@accept.receiver_id),:sender_id => @accept.receiver_id,:notification_type=>"Timed")
   MutualLikeMailer.mutual_like_mailer(@accept.sender_id, current_user).deliver

    #return
  end

  def reject_request
    #render :json => Like.find_by_receiver_id_and_sender_id(params[:id], current_user.id)
    #render :json => Like.find_by_receiver_id_and_sender_id(current_user.id, params[:id])
    #return
    #@reject=Like.find(params[:id])
    @reject=Like.find_by_receiver_id_and_sender_id(params[:id], current_user.id)
    if !@reject.nil?
      @reject.status=false
      @reject.save!
      redirect_to user_profile_path(@reject.sender_id), notice: 'Bummer! Better luck next time ;)'
    else
      redirect_to quick_matches_path, notice: "You haven't sent request to this person."
    end

    return
  end

  def reject_match
    #render :json => params[:id]
    #return
    @base_match = BaseMatch.find(params[:id])
    #render :json => @base_match
    #return
    @rejected_match = RejectedMatch.create(:rejected_target=>@base_match.target_id, :user_id=>current_user.id)
    @rejected_match.save!
    @base_match.destroy
    redirect_to quick_matches_path, notice: 'Bummer! Better luck next time ;)'
  end

  def block_user
    @user_to_be_blocked = params[:id]
    #render :text => @user_to_be_blocked
    #return
    @base_match = BaseMatch.where(:user_id => current_user.id, :target_id => @user_to_be_blocked).first
    #render :json => @base_match
    #return
    @rejected_match = RejectedMatch.create(:rejected_target=>@base_match.target_id, :user_id=>current_user.id)
    @rejected_match.save!
    @base_match.destroy
    redirect_to quick_matches_path, notice: 'You have blocked the user.'
  end

  def importing_institute
    if request.post? && params[:file].present?
      DomainName.import(params[:file])
      #redirect_to '/employee_masters', notice: "Slides imported."
    else
      redirect_to '/', notice: "Slides couldn't be imported."
    end
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


  def import_domain_name
    render :layout => false
  end



end
