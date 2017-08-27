class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  belongs_to :organization

  enum role: {
    unknown: 0,
    level1: 1,
    level2: 2,
    admin: 10
  }
  # make these work later:
  # after_create :send_admin_mail
  after_update :notify_email_change, if: -> { email_changed? }
  after_update :notify_password_change, if: -> { encrypted_password_changed? }

  def notify_email_change
    puts "Sending email change to #{email_was}"
    puts "Sending email change to #{email}"
  end

  def notify_password_change
    puts "Sending password change to #{email}"
  end

  # def send_admin_mail
  #   AdminMailer.new_user_waiting_for_approval(self).deliver
  # end       

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end
end
