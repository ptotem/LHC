module ApplicationHelper

  def get_content_for(key)
    if SiteContent.find_by_key(key).nil?
      "Content Unavailable"
    else
      raw(SiteContent.find_by_key(key).value)
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





end
