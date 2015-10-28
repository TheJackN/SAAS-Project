class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize (user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    (user.standard? && not wiki.private?) || user.admin? || user.premium?
  end

  def create?
  end

  def destroy?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
