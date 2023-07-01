class UserPolicy < ApplicationPolicy
  def document?
    user.admin?
  end

  def approved?
    user.admin?
  end

  def rejected?
    user.admin?
  end
end
