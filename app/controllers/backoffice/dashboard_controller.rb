class Backoffice::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @items = Item.all
    @items.each do |item|
      @total_amount += item.amount
      @total_value += item.value.to_f * item.amount.to_i
    end
  end
end
