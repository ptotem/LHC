class Ability
  include CanCan::Ability
  #
  #def initialize(user)
  #  #
  #  user ||= User.new # guest user (not logged in)
  #
  #  puts "is_admin #{user.is_admin?}"
  #  if user.is_admin == true
  #    can :access, :rails_admin # grant access to rails_admin
  #  else
  #    cannot :access, :rails_admin # grant access to rails_admin
  #  end
  #end

  def initialize(user)

    user ||= User.new
    case user.is_admin
      when true
        can :access, :rails_admin # grant access to rails_admin
        can :dashboard
        can :manage, :all
        can :import, :all

      else
        cannot :manage, :all
        cannot :access, :rails_admin # grant access to rails_admin
        cannot :dashboard
      end
    end


end
