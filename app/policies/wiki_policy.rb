class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize (user, wiki)
    @user = user
    @wiki = wiki
  end

  def index
  end

  def update?
    (user.standard? && wiki.private? == false) || user.admin? || user.premium?
  end

  def create?
    (user.standard? && wiki.private? == false) || user.admin? || user.premium?
  end

  def destroy?
    (user.standard? && wiki.private? == false) || user.admin? || user.premium?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
