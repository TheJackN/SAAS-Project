class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

# The way these are written, a nil user will raise exception errors.

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
    user.present? && (wiki.user == user || user.admin?)
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
    user.present? && (wiki.user == user || user.admin?) # collaborator
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
        return ((scope.where(user: 'user')) && (scope.where(private: false)))
      end
    end
  end
end

# if policy(Wiki.new).create?
#
# def create
#   #load
#   @wikis = policy_scope(Wiki)
#   authorize @wiki
# end
