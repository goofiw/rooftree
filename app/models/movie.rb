class Movie < ActiveRecord::Base
  mount_uploader :poster_image, ImageUploader
  scope :load_movies, ->(params) {
    title = params[:title]
    director = params[:director]
    length = params[:length]
    
    # puts matched.inspect
    if length != ""
     length = "<= 90" if length == '0'
     length = "BETWEEN 90 AND 120" if length == '1'
     length = ">= 120" if length == '2'
    end

    matched = matched.includes.where("runtime_in_minutes ?", length) if length && !length.empty?
    matched = matched.includes.where("title LIKE ?", title) if title && !title.empty?
    matched = matched.includes.where("director LIKE ?", director) if director && !director.empty?
    matched = Movie.all.page(params[:page]).per(5) if !matched
    # includes.where("#{col} LIKE ?", params[col]) if params[col] && !params[col].empty?
  } 
    

  
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

  def search
    title = params[:title]
    director = params[:director]
    length = params[:length]
    
    # puts matched.inspect
    if length != ""
      length = "<= 90" if length == '0'
      length = "BETWEEN 90 AND 120" if length == '1'
      length = ">= 120" if length == '2'
    end

    matched = matched.includes.where("runtime_in_minutes ?", length) if length && !length.empty?
    matched = matched.includes.where("title LIKE ?", title) if title && !title.empty?
    matched = matched.includes.where("director LIKE ?", director) if director && !director.empty?
    matched = Movie.includes.all if !matched
    matched 
  end

end
