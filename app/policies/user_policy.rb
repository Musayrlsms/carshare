class UserPolicy < ApplicationPolicy
  def document?
    user.admin?
  end
end
