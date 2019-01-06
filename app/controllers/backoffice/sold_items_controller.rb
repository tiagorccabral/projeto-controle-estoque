class Backoffice::SoldItemsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: SoldItemDatatable.new(params, view_context: view_context) }
    end
  end
end
