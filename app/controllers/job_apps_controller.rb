class JobAppsController < ApplicationController

  get '/job_apps' do
    redirect_if_not_logged_in
    @apps = current_user.job_apps
    erb :'job_apps/index'
  end

  get '/job_apps/inactive' do #secondary index
    redirect_if_not_logged_in
    inactive = []
    inactive << current_user.job_apps.no_offer << current_user.job_apps.withdrawn
    @inactive_apps = inactive.flatten
    erb :'job_apps/inactive'
  end
  
  private

  def redirect_if_not_authorized
    if @job_app.user != current_user
      #message - Not accesible or other not available message
      redirect '/'
    end
  end
end