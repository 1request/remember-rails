class WelcomeController < ApplicationController
  def index
  end

  def dl
    redirect_to 'https://itunes.apple.com/us/app/remember./id926026469?mt=8'
  end
end
