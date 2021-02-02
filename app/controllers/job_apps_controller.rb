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

  get '/job_apps/new' do
    redirect_if_not_logged_in
    erb :'job_apps/new'
  end

  post '/job_apps' do
    app = JobApp.new(params[:app])
    app.user = current_user 
    
    if app.save
      if !params[:follow_up].values.empty?
        app.follow_ups.create(params[:follow_up])
      end
       redirect "/job_apps/#{app.id}"
    else
      #message - Unable to save. Make sure to fill in required app fields, including both follow-up action fields if adding an action.
      redirect '/job_apps/new'
    end 
  end

  get '/job_apps/:id' do
    @app = JobApp.find_by(id: params[:id])
    if @app && @app.user == current_user
      erb :'job_apps/show'
    else
      redirect '/'
    end
  end

  get '/job_apps/:id/edit' do
    
  end

  patch '/job_apps/:id' do
    
  end

  delete '/job_apps/:id' do
    
  end
  
  private

  def redirect_if_not_authorized
    if @app.user != current_user
      #message - Not accesible or other not available message
      redirect '/'
    end
  end
end