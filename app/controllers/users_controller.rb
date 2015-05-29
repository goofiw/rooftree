class UsersController < ApplicationController
  def new
  	@user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id # auto log in
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    UserMailer.deletion_email(user)
    user.destroy
    flash[:notice] = "His name was Robert Paulson"
    redirect_to admin_users_path
  end


  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.all
  end



  protected

  def user_params
  	params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
end
