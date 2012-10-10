class MoviesController < ApplicationController
  before_filter :simulate_latency, :only => :search
  def index
  end

  def search
    @movies = Movie.where('title like ?', "#{params[:q]}%").order("title asc").limit(10)
    @results = @movies.collect do |m|
      {:label => m.title}
    end
    render :json => @results
  end

  private
  # simple hack to accentuate local search results
  # if the server is too fast, local search results aren't really that useful
  def simulate_latency
    sleep 0.5
  end
end
