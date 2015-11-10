class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize (user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    if wiki.private? == false
      return wiki
    elsif wiki.private? == true && user
      user.admin? || user.premium?
    end
  end

  def update?
    if wiki.private? == false
      user.present? && (wiki.user == user || user.admin?)
    else
      user.present? && (wiki.user == user && user.premium? || user.admin?)
    end
  end

  def new?
    (user.present? && wiki.private? == false) || user.admin? || user.premium?
  end

  def create?
    (user.present? && wiki.private? == false) || user.admin? || user.premium?
  end

  def destroy?
    user.present? && (wiki.user == user || user.admin?)
  end

  def edit?
    if wiki.private? == false
      user.present? && (wiki.user == user || user.admin?)
    else
      user.present? && (wiki.user == user && user.premium? || user.admin?) # collaborator
    end
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user, @scope = user, scope
    end

    def resolve
      if user == nil || user.standard?
        return (scope.where(private: false))
      elsif user.admin?
        return scope.all
      elsif user.premium?
        return scope.all.select {|w| w.private == false || w.user == user}
      end
    end
  end
end
