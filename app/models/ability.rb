class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :edit, :update, :destroy, :to => :modify

    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end

    can :modify, MusicChoice do |m|
      m.user == user
    end

    cannot :like, MusicChoice do |m|
      m.user == user
    end

    can :like, MusicChoice do |m|
      m.user != user
    end

    cannot :like, Comment do |c|
      c.user == user
    end

    can :like, Comment do |c|
      c.user != user
    end

    cannot :like, Suggestion do |s|
      s.user == user
    end

    can :like, Suggestion do |s|
      s.user != user
    end

    can :suggestion, MusicChoice do |m|
      m.user != user
    end

    can :update, Suggestion do |s|
      user == s.music_choice.user
    end

    can :stashed_music, MusicChoice do |m|
      m.user != user
    end

    can :follow, User do |u|
      u != user
    end

    can :delete, Comment do |c|
      c.user == user || c.music_choice.user == user
    end

    can :delete, Suggestion do |c|
      c.user == user || c.music_choice.user == user
    end
  end

end
