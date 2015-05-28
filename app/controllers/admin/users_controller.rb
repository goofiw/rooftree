class Admin::UsersController < Admin::DashboardController

	def index
	    @users = User.all.page(params[:page]).per(1)
  end


  
end
