class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!
  # Create an Authentications model which belongs to User
  # Add provider:string and uid:string to both User and Authentications.
  # Ensure that associations and attr_accessible are correctly mapped in the Models
  # Add the Omniauth.rb initializer
  # Add /user/auth/:provider/callback to the routes
  # /user/auth/:provider is handled by the Oauth gem

  # Callback function of omniauth redirects back to this function.
  # This creates a user if none exists or signs in a user if he exists

  def create
    auth=request.env["omniauth.auth"]
    render :json => auth
    return
    #render :json => "#{auth.extra.raw_info.email}, #{auth.extra.raw_info.email.nil?}"
    #return

    if auth.provider=='facebook' # Checking if request comes from facebook or twitter
                                 #if User.find_by_email(auth.info.email).nil?
      users_email = auth.extra.raw_info.email
      user_gender = auth.extra.raw_info.gender

      if users_email.nil?
        #redirect_to "/", :notice=>"Your e-mail is secured, can't be fetched."
        render :text => "Your e-mail is secured, can't be fetched."
        return
      else
        if User.where(:email=>users_email).first.nil?
          @user = User.create(:provider => auth["provider"], :email => users_email, :password => Devise.friendly_token[0, 20], :uid => auth["uid"])
          if user_gender == "male"
            @user.demographic.male = true
            @user.criterion.male = false
          else
            @user.demographic.male = false
            @user.criterion.male = true

          end
          @user.demographic.nickname = "No Nickname"
          @user.confirmed_at = Time.now
          @user.save!
          sign_in(:user, @user)
          #redirect_to authenticated_root_path
          redirect_to fill_dates_path
          #render :text => "User Created, #{@user}"
          #return
        else
          @user=User.where(:email=>users_email).first
          sign_in(:user, @user)
          #redirect_to authenticated_root_path
          redirect_to fill_dates_path
          #render :text => "User Found, #{@user}"
          #return
        end
      end

    end

  end

end
