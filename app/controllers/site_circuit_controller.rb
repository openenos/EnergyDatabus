class SiteCircuitController < ApplicationController
	include ApplicationHelper
  
  layout 'dashboard'
  
  def index
    @site = Site.find_by_display(params[:site])
    @site = Site.first unless @site.present?
    @channel = Circuit.find_by_display(params[:circuit])
    @channel = @site.panels.first.circuits.first
  end
end
