class SiteCircuitController < ApplicationController
	include ApplicationHelper
  
  layout 'dashboard'
  
  def index
    @site = Site.find_by_display(params[:site])
    @site = Site.first unless @site.present?
    @circuit = Circuit.find_by_display(params[:circuit])
    @circuit = @site.panels.first.circuits.first unless @circuit.present?
    	
  end
end
