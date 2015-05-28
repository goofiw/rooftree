class User < ActiveRecord::Base
	has_one :reviews
  
  after_destroy :notify_deletion

	has_secure_password

	def full_name
		"#{firstname} #{lastname}"
	end

	def notify_deletion
    
	end
end
