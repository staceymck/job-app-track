require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') {SecureRandom.hex(64)}
    register Sinatra::Flash
  end

  get "/" do
    redirect '/job_apps' if logged_in?  #if logged in, show the user their dashboard page
    erb :'users/new' #if not logged in, show visitor the signup page
  end

  get "/not_found" do
    erb :not_found
  end

  not_found do
    redirect "/not_found"
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
