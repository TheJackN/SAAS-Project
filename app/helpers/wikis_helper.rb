module WikisHelper
  def user_authorized_for_new_wiki?
    current_user
  end

  def user_authorized_for_crud?(wiki)
    current_user && (current_user.admin? || current_user == wiki.user)
  end

  def user_authorized_for_private?
    current_user && (current_user.admin? || current_user.premium?)
  end
end
