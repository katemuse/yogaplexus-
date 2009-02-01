class WelcomeController < ApplicationController    

  
  def index  
    @asanatypes = AsanaType.find(:all)   
    @asanasubtypes = AsanaSubtype.find(:all)  
  end

end
