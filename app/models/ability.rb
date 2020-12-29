# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :create, User
    if user.role?(:user)
      can %i[create update], Submission, user_id: user.id
      can :read, Contest
      can %i[edit delete], User, user_id: user.id
    elsif user.role?(:marker)
      can :manage, [Contest, Submission, Question]
      can %i[create edit delete], User, user_id: user.id
    elsif user.role?(:admin)
      can :manage, :all
    end
  end
end
