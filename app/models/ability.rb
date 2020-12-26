# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :create, User

    if user.role?(:guest) then
      if user.role?(:user) then
        can [:create, :update], Submission, user_id: user.id
        can :read, Contest
        can [:edit, :delete], User, user_id: user.id
        if user.role?(:marker) then
          can :manage, [Contest, Submission, Question]
          if user.role?(:admin) then
            can :manage, :all
          end
        end
      end
    end
  end
end
