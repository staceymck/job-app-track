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
    #redirect if not logged in?
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
    redirect_if_not_authorized_or_valid_record
      
    erb :'job_apps/show'
  end

  get '/job_apps/:id/edit' do
    @app = JobApp.find_by(id: params[:id])
    redirect_if_not_authorized_or_valid_record
    
    erb :'job_apps/edit'
  end

  patch '/job_apps/:id' do
    @app = JobApp.find_by(id: params[:id])
    redirect_if_not_authorized_or_valid_record #do I need to redirect if not logged in for post/patch requests or does this cover it?

    if @app.update(params[:app]) #update saves to database IF validations pass - make sure all required fields still filled
      if !params[:follow_ups].empty?
        binding.pry
        params[:follow_ups].each do |details|
          existing_follow_up = @app.follow_ups.find_by(id:XXXX) #need to access id somehow since other fields may have been changed
          if exisiting_follow_up
            exisiting_follow_up.update(details)
            #error message if not saved
          else
            @app.follow_ups.create(details)
            #error message if not created
          end
        end
        redirect "/job_apps/#{app.id}"
      end
    else 
      #message - unable to update. Make sure to complete all required fields
      redirect "/job_apps/#{app.id}/edit"
    end
  end

  delete '/job_apps/:id' do
    @app = JobApp.find_by(id: params[:id])
    redirect_if_not_authorized_or_valid_record

    @app.destroy
    #message - delete successful?
    redirect '/job_apps'
  end
  
  private

  def redirect_if_not_authorized_or_valid_record
    if @app.nil? || @app.user != current_user
      #message - Not accesible or other not available message
      redirect '/'
    end
  end
end