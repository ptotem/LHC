class MandatoryDetailsController < ApplicationController

  layout "mandatory_details"

  def fill_about_me
    @user = current_user
    @next_page  = fill_ilike_path
    @prev_page = fill_drinking_path
  end

  def fill_ilike
    @user = current_user
    @next_page  = fill_future_plan_path
    @prev_page = fill_about_me_path

  end

  def fill_profilepic
    @user = current_user
    @next_page = my_dashboard_path
    @prev_page = fill_friend_speak_path

  end

  def future_plan
    @user = current_user
    @next_page  = fill_friend_speak_path
    @prev_page = fill_ilike_path
  end
  def friend_speak
    @user = current_user
    @next_page = fill_profilepic_path
    @prev_page = fill_future_plan_path


  end

  def fill_dates
    @user = current_user
    @next_page  = fill_smoking_path

  end

  def fill_smoking
    @user = current_user
    @next_page  = fill_drinking_path
    @prev_page = fill_dates_path

  end

  def fill_drinking

    @user = current_user
    @next_page  = fill_about_me_path
    @prev_page = fill_smoking_url
  end

end
