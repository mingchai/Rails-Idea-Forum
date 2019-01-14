class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    alias_action(:create, :read, :edit, :update, :delete, to: :crud)
    
    can(:crud, Idea) do |idea|
      idea.user == user
    end
  end
end
