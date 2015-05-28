module MoviesHelper

	def search
		title = params[:title]
		director = params[:director]
		length = params[:length]
		matched = Movie.all

		if length != ""
			length = "<= 90" if length == '0'
			length = "BETWEEN 90 AND 120" if length == '1'
			length = ">= 120" if length == '2'
		end

    # matched = Movie.where("title like ? or director like ?", "%#{title}%","%#{director}%")
		matched = matched.where("title LIKE ?", "#{title}") if title && title != ""
		matched = matched.where("director LIKE ?", "#{director}") if director && director != ""
		matched = matched.where("runtime_in_minutes #{length}")	if length && length != ""
		matched
	end

	def formatted_date(date)
		date.strftime("%b %d, %Y")
	end
end
