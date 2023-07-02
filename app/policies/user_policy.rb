class UserPolicy < ApplicationPolicy
  def document?
    user.admin?
  end

  def update?
    user == record
  end

  def approved?
    user.admin?
  end

  def rejected?
    user.admin?
  end
end
