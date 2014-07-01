class HomeController < ApplicationController

  layout :resolve_layout

  #private

  def resolve_layout
    puts "action_name :- #{action_name}"
    puts "device_type :- #{device_type}"
    if action_name == "about_us" || action_name == "contact_us"
      #if device_type == :desktop
      #"dashboard_and_profile_layout"
    elsif action_name == "about_us_mobile" || action_name == "contact_us_mobile"
      #elsif device_type == :mobile
      "dashboard_and_profile_layout_mobile"
    end
  end

  before_filter :authenticate_user!,
                :only => [:index]

  def index
    redirect_to current_user.current_route
    return

    @current_user_sign_in_count = current_user.sign_in_count

    if current_user.is_admin?
      redirect_to "/admin"
    else
      if @current_user_sign_in_count == 2 && (!current_user.demographic.nil? || !current_user.criterion.nil?)
        redirect_to welcome_dashboard_path
      elsif  @current_user_sign_in_count > 2
        redirect_to my_dashboard_path
      elsif  @current_user_sign_in_count == 1
        redirect_to fill_matching_criteria_path
      end
    end

  end

  def about_us
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to about_us_mobile_path
    elsif device_type == :tablet
      render :text => "render tablet pages"
      return
    else
      #render :text => "render desktop pages"
      #return
    end
  end

  def about_us_mobile
    #render :text => "here is about_us_mobile"
    #return
  end

  def contact_us
    if device_type == :mobile
      #render :text => "render mobile pages"
      #return
      redirect_to contact_us_mobile_path
    elsif device_type == :tablet
      render :text => "render tablet pages"
      return
    else
      #render :text => "render desktop pages"
      #return
      @query = Query.new
    end

  end

  def contact_us_mobile
    #render :text => "here is contact_us_mobile"
    #return
    @query = Query.new
  end

end
