class Backoffice::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @items = Item.all
    @total_amount =0
    @total_value =0
    @value_sold = 0.0
    @total_sold = 0
    @items.each do |item|
      @total_amount += item.amount
      @total_value += item.value.to_f * item.amount.to_i
      @value_sold += item.value_sold.to_f
      @total_sold += item.total_sold.to_i
    end
  end
end
