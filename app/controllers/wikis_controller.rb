class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.build(wiki_params)
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
    @wiki = Wiki.fin(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
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
    @wiki = Wiki.find[params[:id]]

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" Wiki was successfully deleted"
      render :index
    else
      flash[:error] = "Wiki deletion failed"
      render :show
    end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
