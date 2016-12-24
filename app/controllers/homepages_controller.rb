class HomepagesController < ApplicationController
  
  #skip_before_filter :authenticate_user!, only: :index
  before_action :authenticate_user!, only: :dashboard

  def dashboard
  
  end

  def landing_page
        
  end
  
  def about

  end
  
  def contact 

  end

  def faq

  end

  def pricing

  end
    
end
