class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    poi_alerts_path
  end

  def after_update_path_for(resource)
      poi_alerts_path
    end
end