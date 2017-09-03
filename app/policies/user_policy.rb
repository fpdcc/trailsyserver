class UserPolicy < DataPolicy
	def approve?
		user.admin?
	end
end