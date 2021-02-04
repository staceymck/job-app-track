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
    redirect_if_not_logged_in #can also check that app doesn't exist
    app = JobApp.new(params[:app])
    app.user = current_user 
    
    if app.save
      if !params[:follow_up].values.empty?
        app.follow_ups.create(params[:follow_up])
      end
       redirect "/job_apps/#{app.id}"
    else
      flash[:error] = "Unable to save. Make sure to fill in required app fields, including both follow-up action fields if adding a new action. 
        Follow-up action dates must be in the future."
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
    redirect_if_not_authorized_or_valid_record

    if !@app.update(params[:app]) 
      flash[:edit_app_error] = "Could not save changes. Make sure required app fields are complete."
      redirect "/job_apps/#{app.id}/edit"
    end

    unless params[:new_follow_up].values.all?("")
      new_follow_up = @app.follow_ups.build(params[:new_follow_up]) 
      if !new_follow_up.save
        flash[:new_follow_up_error] = "New follow up action could not be saved. Make sure to include an action and future date."
      end
    end

    if params[:saved_follow_ups]
      params[:saved_follow_ups].each do |details|
        follow_up = FollowUp.find_by(id: details[:id])
        if details[:delete] && details[:delete] == "true"
          follow_up.destroy
        else
          details[:action_status] = "incomplete" if !details.keys.include?("action_status")
            if !follow_up.update(
              action: details[:action],
              complete_by: details[:complete_by],
              action_status: details[:action_status])
              flash[:update_follow_up_error] = "Could not update follow-up action(s). Make sure to include an action and future date."
            end
        end
      end
    end
    redirect "/job_apps/#{app.id}"
  end
  
  delete '/job_apps/:id' do
    @app = JobApp.find_by(id: params[:id])
    redirect_if_not_authorized_or_valid_record

    @app.destroy
    flash[:app_deleted] = "Application deleted"
    redirect '/job_apps'
  end
  
  private

  def redirect_if_not_authorized_or_valid_record
    if @app.nil? || @app.user != current_user
      redirect '/'
    end
  end
end