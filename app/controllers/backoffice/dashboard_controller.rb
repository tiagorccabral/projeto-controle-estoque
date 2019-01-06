class Backoffice::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @items = Item.all
    soldItems = SoldItem.all
    @total_amount =0
    @total_value =0
    @sold_value = 0.0
    @sold_amount = 0
    @items.each do |item|
      @total_amount += item.amount
      @total_value += item.value.to_f * item.amount.to_i
    end
    soldItems.each do |soldItem|
      @sold_value += soldItem.value
      @sold_amount += soldItem.amount
    end
  end
end
