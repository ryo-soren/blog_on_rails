# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new 
    
    alias_action :create, :read, :update, :delete, :to => :crud

    if user.admin?
      can :manage, :all
    end

    can :crud, Post do |post|
        user == post.user
    end

    can :crud, Comment do |comment|
      user == comment.user || user == comment.post.user
    end

  end
end
