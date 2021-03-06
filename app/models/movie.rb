class Movie < ActiveRecord::Base
  mount_uploader :poster_image, ImageUploader
  
	has_one :poster
	has_many :reviews

validates :title,
  presence: true

validates :director,
  presence: true

validates :runtime_in_minutes,
  numericality: { only_integer: true }

validates :description,
  presence: true

validates :release_date,
  presence: true

validate :release_date_is_in_the_future, :file_or_url

def review_average
	reviews.sum(:rating_out_of_ten)/reviews.size
end

protected

def release_date_is_in_the_future
  if release_date.present?
    errors.add(:release_date, "should probably be in the future") if release_date < Date.today
  end
end

def file_or_url
  if :url == nil && :title == nil
    errors.add(:no_image, "Please provide a URL or upload a file")
  end
end

end
