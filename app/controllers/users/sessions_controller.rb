class Users::SessionsController < Devise::SessionsController
  def new
    render :text => "devise/sessions_controller/new - #{params}"
    return
     super
  end

  def create
    render :text => "devise/sessions_controller/create - #{params}"
    return
     super
  end
end
