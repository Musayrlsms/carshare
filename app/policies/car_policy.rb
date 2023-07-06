class CarPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end

  def permit?
    user.admin?
  end

  def nopermit?
    user.admin?
  end

end
