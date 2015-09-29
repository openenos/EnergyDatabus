class HeatmapController < ApplicationController
	include ApplicationHelper
  
  layout 'dashboard'

  def index
  	@site = Site.find_by_display(params[:site])
    @site = Site.first unless @site.present?
  end
end
