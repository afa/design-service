# coding: utf-8
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new_guest  # actually user can already be guest because in application controller we yielded current_or_guest_user

    can :manage, :all  # debug mode

    can :create, PlanDevelopment
    can :create, ReplanningEndorsement
    can :read, PlanDevelopment.by_client(user.id).readonly(false)
    can :read, ReplanningEndorsement.by_client(user.id).readonly(false)
    can :read, Specialist

    can :read, Message.by_user(user.id)

    if user.role == 'client'
    end
    if user.role == 'specialist'
      can :create, PortfolioItem
      can :update, PortfolioItem, specialist_id: user.specialist.id
    end
    if user.role == 'moderator'
      can :manage, PortfolioItem
    end
    if user.role == 'admin'
      can :manage, :all
      can :manage, ActiveAdmin::Page, name: "Dashboard"
    end


    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

  end
end
