class JobAppsController < ApplicationController

  get '/job_apps' do
    redirect_if_not_logged_in
    @user = current_user
    @apps = @user.job_apps
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