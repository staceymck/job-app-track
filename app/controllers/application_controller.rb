require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    redirect '/job_apps' if logged_in?  #if logged in, show the user their dashboard page
    erb :'users/new' #if not logged in, show visitor the signup page
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        #flash message - login to continue
        redirect '/'
      end
    end
  end

end
