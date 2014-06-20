module ApplicationHelper

  def get_content_for(key)
    if SiteContent.find_by_key(key).nil?
      "Content Unavailable"
    else
      raw(SiteContent.find_by_key(key).value)
    end
  end

  def get_image_from_content(key)
    if SiteContent.find_by_key(key).nil?
      "/assets/background.jpg"
    else
      SiteContent.find_by_key(key).avatar.url
    end

  end


  def checking_status_likes(uid)
    if Like.find_by_sender_id_and_receiver_id(uid,current_user.id).nil? and Like.find_by_sender_id_and_receiver_id(current_user.id,uid).nil?
      return false
    else
      if Like.find_by_sender_id_and_receiver_id(uid,current_user.id).nil?
        if Like.find_by_sender_id_and_receiver_id(current_user.id,uid).nil?
          false
        else
          Like.find_by_sender_id_and_receiver_id(current_user.id,uid).status
        end
      else
        Like.find_by_sender_id_and_receiver_id(uid,current_user.id).status
      end
    end
  end





  def get_user_name(id)
    if User.find(id).demographic.nickname.nil?
      "No name Found"
    else
      User.find(id).demographic.nickname
    end

  end

  def get_user_image(id)
    if User.find(id).demographic.avatar.nil?
      "/assets/profile_pic.jpg"
    else
      User.find(id).demographic.avatar.url(:medium)
    end
  end

  def get_user_age(id)
    User.find(id).age
  end

  def get_user_gender(id)
    if User.find(id).demographic.male?
      "Male"
    else
      "Female"
    end
  end

  def get_user_location(id)
    User.find(id).demographic.location
  end

  def get_user_institute(id)
    Institution.find(User.find(id).demographic.last_institute).name rescue "NA"
  end

  def get_user_about_list(id)
    u=User.find(id)
    u.about_lists
  end

  def timer_countdown(id)
    u=User.find(id)
    if u.last_matched_time.nil? || ((((u.last_matched_time+3.days).to_i - Time.now.to_i)/3600) <= 0)
      "X"
    else
      ((u.last_matched_time+3.days).to_i - Time.now.to_i)/3600
    end
  end



  def check_icebreaker_status(uid)
    final_verdict_sent=false
    final_verdict_rec=false
    if IceBreaker.find_by_sender_id_and_receiver_id(uid,current_user.id).nil? and IceBreaker.find_by_sender_id_and_receiver_id(current_user.id,uid).nil?
      return false
    else
      if !IceBreaker.find_by_sender_id_and_receiver_id(current_user.id,uid).nil?
        i=IceBreaker.find_by_sender_id_and_receiver_id(current_user.id,uid)
        if i.ice_status == true
          if i.icebreaker_answers.where(:ice_ans_status => false).blank? and i.icebreaker_answers.count > 0
            final_verdict_sent = true
          end
        end
      end
      if !IceBreaker.find_by_sender_id_and_receiver_id(uid,current_user.id).nil?
        i=IceBreaker.find_by_sender_id_and_receiver_id(uid,current_user.id)
        if i.ice_status == true
          if i.icebreaker_answers.where(:ice_ans_status => false).blank? and i.icebreaker_answers.count > 0
            final_verdict_rec = true
          end
        end
      end
        return (final_verdict_sent and final_verdict_rec)
    end
  end

  def check_my_ice_breaker_sent_status(uid)
    final_verdict_sent=false
    if !IceBreaker.find_by_sender_id_and_receiver_id(current_user.id,uid).nil?
      i=IceBreaker.find_by_sender_id_and_receiver_id(current_user.id,uid)
      if i.ice_status == true
        if i.icebreaker_answers.where(:ice_ans_status => false).blank? and i.icebreaker_answers.count > 0
          final_verdict_sent = true
        end
      end
    end
    return (final_verdict_sent)
  end


  def get_like_status(uid)
    if !Like.where(:sender_id => current_user.id, :receiver_id => uid).first.nil?
      return Like.where(:sender_id => current_user.id, :receiver_id => uid).first.status
    end
    if !Like.where(:sender_id => uid, :receiver_id => current_user.id).first.nil?
      return Like.where(:sender_id => uid, :receiver_id => current_user.id).first.status
    end
  end



end
