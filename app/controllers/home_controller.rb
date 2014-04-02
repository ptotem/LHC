class HomeController < ApplicationController

  before_filter :authenticate_user!,
                :only => [:index]

  def index
    @current_user_sign_in_count = current_user.sign_in_count
    if @current_user_sign_in_count > 1
      redirect_to my_dashboard_path
    else
      redirect_to fill_matching_criteria_path
    end
  end

  def about_us

  end

end
