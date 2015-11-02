class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_wiki, except: [:index, :new, :create]
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: [:index]

  def index
    @wikis = policy_scope(Wiki.all)
  end

  def show
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "New Wiki Successfully Created"
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating your wiki, please try again"
      render :new
    end
  end

  def edit
  end

  def update
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki Updated"
      redirect_to @wiki
    else
      flash[:error] = "Wiki failed to update, please try again"
      render :edit
    end
  end

  def destroy
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" Wiki was successfully deleted"
      render :index
    else
      flash[:error] = "Wiki deletion failed"
      render :show
    end
  end

  private

  def load_wiki
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
