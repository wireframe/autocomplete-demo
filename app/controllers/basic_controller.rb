class BasicController < ApplicationController
  def index
  end

  def search
    @movies = Movie.where('title like ?', "#{params[:q]}%").limit(10)
    @results = @movies.collect do |m|
      {:label => m.title}
    end
    render :json => @results
  end
end
