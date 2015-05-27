class User < ActiveRecord::Base
	has_one :reviews

	has_secure_password

	def full_name
		"#{firstname} #{lastname}"
	end
end
