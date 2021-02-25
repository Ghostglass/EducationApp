class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  # GET /
  def home
  end

  # GET /contact-us
  def contact_us   
  end
  
end
