class Admin::DashboardController < ApplicationController


  def index
    restrict_access_to_admin
  end

end
