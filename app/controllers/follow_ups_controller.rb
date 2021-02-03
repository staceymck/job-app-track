class FollowUpsController < ApplicationController

  delete '/follow_up/:id' do
    @follow_up = FollowUp.find_by(id: params[:id])
    if @follow_up && @follow_up.user == current_user 
      @follow_up.destroy
      #message about successful delete
    end
    redirect '/'
  end
end
