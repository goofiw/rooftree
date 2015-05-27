class Admin::UsersController < ApplicationController

	def index
		  restrict_access_to_admin
	    @users = User.all.page(params[:page]).per(1)
  end
end
