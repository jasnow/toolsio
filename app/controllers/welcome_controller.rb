class WelcomeController < ApplicationController
  
  skip_before_filter :authenticate_user!, only: :index
     
  def index
        
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
