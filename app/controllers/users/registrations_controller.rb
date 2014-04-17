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
    #render :json => params#[:user][:demographic_attributes]
    #return
    @user = current_user
    respond_to do |format|
      #if @user.update_attributes(params[:user].permit[:demographics_attributes])
      if @user.update(params.require(:user).permit(:username,:email,:password,:password_confirmation,:phone, :validate_username,:avatar, :avatar_cache, :remove_avatar, :current_password,:demographic_attributes=>[:id,:male, :name,:nickname,:dob,:smoking,:drinking,:country,:city,:religion,:avatar], :criterion_attributes=>[:male,:minage,:maxage,:smoking,:drinking], :attendances_attributes=>[:user_id, :institution_id]))
        format.html { redirect_to "/profile/#{@user.id}", notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @demographic.errors, status: :unprocessable_entity }
      end
    end

  end



end
