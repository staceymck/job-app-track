class FollowUpsController < ApplicationController

  delete '/follow_up/:id' do
    @follow_up = FollowUp.find_by(id: params[:id])
    if @follow_up && @follow_up.job_app.user == current_user 
      @follow_up.destroy
    end
    redirect "/job_apps/#{@follow_up.job_app.id}"
  end
end
