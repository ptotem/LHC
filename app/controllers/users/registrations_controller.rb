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

  def update_profile
    #render :json => params#[:user][:demographic_attributes]
    #return
    @user = current_user
    respond_to do |format|
      if @user.update(params[:user])
        format.html { redirect_to "/profile/#{@user.id}", notice: 'Demographic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @demographic.errors, status: :unprocessable_entity }
      end
    end

  end



end
