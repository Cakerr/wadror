class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @recent = Rating.recent
    @most_active_users = User.most_active 3
    @best_beers = Beer.best_average 3
    @best_breweries = Brewery.best_average 3
    @best_styles = Style.best_average 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end