class MoviesController < ApplicationController
  def index
  end

  def search
    @movies = Movie.where('title like ?', "#{params[:q]}%").order("title asc").limit(10)
    @results = @movies.collect do |m|
      {:label => m.title}
    end
    render :json => @results
  end
end
