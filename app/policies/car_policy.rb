class CarPolicy < ApplicationPolicy
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
