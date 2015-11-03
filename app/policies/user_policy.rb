class UserPolicy < ApplicationPolicy
  attr_reader :user

# The way these are written, a nil user will raise exception errors.

  def initialize (user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    user.present?
  end

  def upgrade?
    user.standard?
  end

  def downgrade?
    user.premium?
  end
end
