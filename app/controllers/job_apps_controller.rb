class JobAppsController < ApplicationController

  get '/job_apps' do
    redirect_if_not_logged_in
    @user = User.find_by(id: session[:user_id]) 
    erb :'job_apps/index'
  end
  
  private

  def redirect_if_not_authorized
    if @job_app.user != current_user
      #message - Not accesible or other not available message
      redirect '/'
    end
  end
end