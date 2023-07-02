class ModelPolicy < ApplicationPolicy
  def index?
   
  end

  def show?
    
  end

  def new?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
