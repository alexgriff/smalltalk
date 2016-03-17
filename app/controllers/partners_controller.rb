class PartnersController < ApplicationController

  def show
    @partner = Partner.find(params[:id])
  end

  def index

  end


end