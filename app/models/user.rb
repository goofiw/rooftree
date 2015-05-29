class User < ActiveRecord::Base
	has_many :reviews
  
  after_destroy :notify_deletion

	has_secure_password

	def full_name
		"#{firstname} #{lastname}"
	end

  def get_reviews
    reviews.all
  end
end
