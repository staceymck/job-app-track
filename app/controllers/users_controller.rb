class UsersController < ApplicationController

  get '/signup' do
    redirect '/job_apps' if logged_in?
    erb :'users/new'
  end

  post '/signup' do
    user = User.new(
      username: params[:username],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
      )
    if user.save
      session[:user_id] = user.id
      redirect '/job_apps'
    else
      flash[:user_account_message] = "Passwords must match and username must be unique. Please try again."
      redirect '/signup'
    end
  end

  get '/login' do
    redirect '/job_apps' if logged_in?
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/job_apps'
    else
      flash[:user_account_message] = "Login unsucccessful. Please try again or sign up if you don't have an account."
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/users/:id/delete' do
    redirect_if_not_logged_in
    user = User.find_by(id: params[:id])
    if user == current_user
      erb :'non_dashboard_nav', :layout => :layout  do
        erb :'/users/delete'
      end
    else
      redirect '/'
    end 
  end

  delete '/users/:id' do
    redirect_if_not_logged_in
    user = User.find_by(id: params[:id])
    if user == current_user
      user.destroy 
      session.clear
      flash[:user_account_message] = "Account succesfully deleted for: #{user.username}"
      redirect '/signup'
    else
      redirect '/'
    end
  end
end