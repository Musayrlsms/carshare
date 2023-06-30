class ProfilePolicy < ApplicationPolicy
  def document?
    user.admin?
  end
end