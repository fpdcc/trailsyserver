class AlertPolicy < ApplicationPolicy
  
  def index?
  	user.admin?
  end

  def poi?
  	user.level1? or user.level2? or user.admin?
  end

  def trail?
  	user.level2? or user.admin?
  end

  def global?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def new?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.level1? or user.level2? or user.admin?
  end

  def update?
    user.level1? or user.level2? or user.admin?
  end

  def destroy?
    user.level1? or user.level2? or user.admin?
  end
end