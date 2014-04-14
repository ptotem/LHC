class HomeController < ApplicationController

  before_filter :authenticate_user!,
                :only => [:index]

  def index
    @current_user_sign_in_count = current_user.sign_in_count

    if current_user.is_admin?
      redirect_to "/admin"
    else
      if @current_user_sign_in_count == 2 && (!current_user.demographic.nil? || !current_user.criterions.nil?)
        redirect_to welcome_dashboard_path
      elsif  @current_user_sign_in_count > 2
        redirect_to my_dashboard_path
      elsif  @current_user_sign_in_count == 1
        redirect_to fill_matching_criteria_path
      end
    end

  end

  def about_us

  end

  def contact_us
    @query = Query.new

  end

end
