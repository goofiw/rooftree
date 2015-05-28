class Admin::DashboardController < ApplicationController
  
  before_filter :restrict_access_to_admin

  def index
    
  end

end
