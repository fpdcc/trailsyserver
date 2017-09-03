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

  def update?
    user.admin?
  end
end