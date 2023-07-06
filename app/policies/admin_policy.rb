class AdminPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
end
