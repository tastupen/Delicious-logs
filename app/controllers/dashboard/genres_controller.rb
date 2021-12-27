class Dashboard::GenresController < ApplicationController
  before_action :authenticate_admin!, except: :index
  before_action :set_genre, only: %w[show edit update destroy]
  layout "dashboard/dashboard"
  
  def index
    @genres = Genre.display_list(params[:page])
    @genre = Genre.new
  end
  
  def create
    genre = Genre.create(genre_params)
    genre.save
    redirect_to dashboard_genres_path
  end
  
  def edit
  end
  
  def update
    @genre = Genre.update(category_params)
    @genre.save
    redirect_to dashboard_genres_path
  end
  
  def destroy
    @genre.destroy
    redirect_to dashboard_genres_path
  end
  
  private
  
    def set_genre
      @genre = Genre.find(params[:id])
    end
    
    def genre_params
      params.require(:genre).permit(:name,:description,:major_category_name)
    end
end
