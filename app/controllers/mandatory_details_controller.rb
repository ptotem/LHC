class MandatoryDetailsController < ApplicationController

  #layout "mandatory_details"

  layout :resolve_layout

  #private

  def resolve_layout
    puts "action_name :- #{action_name}"
    puts "device_type :- #{device_type}"
    #if action_name == "fill_dates" || action_name == "fill_smoking" || action_name == "fill_drinking" || action_name == "fill_about_me" || action_name == "fill_ilike" || action_name == "future_plan" || action_name == "friend_speak" || action_name == "fill_profilepic"
      if device_type == :desktop
      "mandatory_details"
    #elsif action_name == "fill_dates_mobile" || action_name == "fill_smoking_mobile" || action_name == "fill_drinking_mobile" || action_name == "fill_about_me_mobile" || action_name == "fill_ilike_mobile" || action_name == "future_plan_mobile" || action_name == "friend_speak_mobile" || action_name == "fill_profilepic_mobile"
      elsif device_type == :mobile
      "mandatory_details_layout_mobile"
    end
  end

  def fill_about_me
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_about_me_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page  = fill_ilike_path
      @prev_page = fill_drinking_path
    end
  end

  def fill_about_me_mobile
    @user = current_user
    @next_page  = fill_ilike_path
    @prev_page = fill_drinking_path
  end

  def fill_ilike
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_ilike_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page  = fill_future_plan_path
      @prev_page = fill_about_me_path
    end
  end

  def fill_ilike_mobile
    @user = current_user
    @next_page  = fill_future_plan_path
    @prev_page = fill_about_me_path
  end

  def fill_profilepic
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_profilepic_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page = welcome_dashboard_path
      @prev_page = fill_friend_speak_path
    end
  end

  def fill_profilepic_mobile
    @user = current_user
    @next_page = welcome_dashboard_path
    @prev_page = fill_friend_speak_path
  end

  def future_plan
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_future_plan_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page  = fill_friend_speak_path
      @prev_page = fill_ilike_path
    end
  end

  def future_plan_mobile
    @user = current_user
    @next_page  = fill_friend_speak_path
    @prev_page = fill_ilike_path
  end

  def friend_speak
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_friend_speak_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page = fill_profilepic_path
      @prev_page = fill_future_plan_path
    end
  end

  def friend_speak_mobile
    @user = current_user
    @next_page = fill_profilepic_path
    @prev_page = fill_future_plan_path
  end

  def fill_dates
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_dates_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page  = fill_smoking_path
    end
  end

  def fill_dates_mobile
    #render :text => "here is fill_dates_mobile"
    #return
    @user = current_user
    @next_page  = fill_smoking_path
  end

  def fill_smoking
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_smoking_mobile_path
    #elsif device_type == :tablet
    #  render :text => "render tablet pages"
    #  return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page  = fill_drinking_path
      @prev_page = fill_dates_path
    end
  end

  def fill_smoking_mobile
    @user = current_user
    @next_page  = fill_drinking_path
    @prev_page = fill_dates_path
  end

  def fill_drinking
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to fill_drinking_mobile_path
    elsif device_type == :tablet
      render :text => "render tablet pages"
      return
    else
      #render :text => "render desktop pages"
      #return
      @user = current_user
      @next_page  = fill_about_me_path
      @prev_page = fill_smoking_url
    end
  end

  def fill_drinking_mobile
    @user = current_user
    @next_page  = fill_about_me_path
    @prev_page = fill_smoking_url
  end

end
