class BasicController < ApplicationController
  def index
  end

  def search
    results = []
    results << {:label => 'test', :value => 'test'}
    render :json => results
  end
end
