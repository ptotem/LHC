class Users::RegistrationsController < Devise::RegistrationsController

  def new
    #render :text => "devise/reg_controller/new - #{params}"
    #return
     super
  end

  #def new
  #  puts "devise/reg_controller/new - #{params}"
  #  user = build_resource({})
  #  user.build_demographic if user.demographic.blank?
  #  respond_with self.resource
  #end



  def create

    puts "devise/reg_controller/create - #{params}"
    #return
    super
  end

  def update
    @user = current_user
    #render :text=>params
    #return

    if !params[:user][:criterion_attributes].nil?
      if !params[:user][:criterion_attributes][:minage].nil? and !params[:user][:criterion_attributes][:maxage].nil?
      if params[:user][:criterion_attributes][:minage] >= params[:user][:criterion_attributes][:maxage]
        redirect_to fill_dates_path, notice: 'The minimum age cannot be greater than maximum age!'
        return
      end
      end
    end

    if !params[:user][:demographic_attributes].nil?
      if params[:user][:demographic_attributes][:avatar].nil? and params[:user][:current_route] == "/welcome_dashboard"
        redirect_to fill_profilepic_path, notice: 'Please add a photograph!'
        return
      end
    end

    if !params[:user][:hobby_list_ids].nil?
    if !(params[:user][:hobby_list_ids]-[""]).blank?
      params[:user][:hobby_list_ids].reject!{|a| a==""}
      if params[:user][:hobby_list_ids].length !=5
        redirect_to user_profile_path(current_user.id), notice: 'Your profile was not updated.You must exactly specify 5 likes!'
        return
      end
      end
    end

    if !params[:user][:about_list_ids].nil?
    if !(params[:user][:about_list_ids]-[""]).blank?
      params[:user][:about_list_ids].reject!{|a| a==""}
      if params[:user][:about_list_ids].length !=5
        redirect_to user_profile_path(current_user.id), notice: 'Your profile was not updated.You must exactly specify 5 likes!'
        return
      end
      end

    end

    #if params[:user][:hobby_list_ids].length !=5  or  params[:user][:about_list_ids].length !=5
    #  redirect_to "/edit_profile/#{@user.id}", notice: 'Your profile was not updated.You must exactly specify 5 likes!'
    #  return
    #end
    respond_to do |format|
      if params[:user][:current_password].blank?
        if @user.update(params.require(:user).permit(:username,:email,:validate_username,:avatar,:current_route,:first_visit, :avatar_cache, :remove_avatar, :demographic_attributes=>[:id,:male, :name,:nickname,:dob,:smoking,:drinking,:location,:religion,:avatar, :description, :goal,:last_institute,:current_student], :criterion_attributes=>[:id,:male,:minage,:maxage,:smoking,:drinking], :attendances_attributes=>[:user_id, :institution_id], :hobby_list_ids=>[], :about_list_ids=>[], :profession_attributes=>[:name]))
          sign_in @user, :bypass => true
          format.html { redirect_to authenticated_root_path, notice: 'Your profile was successfully updated.' }
          #format.html { redirect_to user_profile_path(@user.id), notice: 'Your profile was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to edit_profile_path(@user.id), notice: 'Password Incorrect.' }
          format.json { render json: @demographic.errors, status: :unprocessable_entity }
        end
      else
        if @user.update_with_password(params.require(:user).permit(:username,:email,:current_password,:current_route,:first_visit, :password,:password_confirmation,:validate_username,:avatar, :avatar_cache, :remove_avatar, :demographic_attributes=>[:id,:male, :name,:nickname,:dob,:smoking,:drinking,:location,:religion,:avatar, :description, :goal,:last_institute,:current_student], :criterion_attributes=>[:male,:minage,:maxage,:smoking,:drinking], :attendances_attributes=>[:user_id, :institution_id], :hobby_list_ids=>[], :about_list_ids=>[], :profession_attributes=>[:name]))
          sign_in @user, :bypass => true
          format.html { redirect_to user_profile_path(@user.id), notice: 'Your profile was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to edit_profile_path(@user.id), notice: 'Password Incorrect.' }
          format.json { render json: @demographic.errors, status: :unprocessable_entity }
        end
      end
    end

    end
  #end



end
