class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find_by(email: params[:email])
    collaboration = user.collaborations.build(wiki: wiki) if user

    if user && collaboration.save
      flash[:notice] = "Collaborator Added."
    else
      flash[:error] = "There was an error adding Collaborator. Please verify that the Collaborator's user id is correct"
    end

    redirect_to wiki
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    #user = User.find(params[:user_id])
    collaboration = Collaboration.find(params[:id])

    if collaboration.destroy
      flash[:notice] = "Collaborator Removed"
    else
      flash[:error] = "There was an error removing Collaborator"
    end

    redirect_to [wiki]
  end
end
