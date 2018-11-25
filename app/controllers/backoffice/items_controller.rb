# frozen_string_literal: true

class Backoffice::ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @items = Item.all
    @total_value = 0.0
    @total_amount = 0
    @items.each do |item|
      @total_amount += item.amount
      @total_value += item.value.to_f * item.amount.to_i
    end
  end

  def sell
    @item = Item.find(params[:id])
    @item.amount = @item.amount - 1
    if @item.amount == 0
      @item.destroy
    else
      @item.save
    end
    respond_to do |format|
      format.html { redirect_to backoffice_items_list_path, notice: 'Quantidade do item diminuida.'}
      format.js {  }
    end
  end

  def items_list
    @items = Item.all.order('updated_at DESC')
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to backoffice_items_path, notice: 'Item foi criado com sucesso.' }
        format.js { }
      else
        format.html { render :new, notice: "Ocorreu um erro. Por favor, preencha todos os campos do formulário." }
        format.js {  }
      end
    end
  end

  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update(item_params_edit)
        format.html { redirect_to backoffice_items_list_path, notice: "Item foi atualizado com sucesso." }
        format.js { }
      else
        format.html { render :edit, notice: "Ocorreu um erro. Por favor, preencha todos os campos do formulário." }
        format.js {  }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_items_path, notice: 'Doação deletada com sucesso.' }
      format.js {}
    end
  end

  private
  def item_params
    params.require(:item).permit(:id, :name, :amount, :value, :donor, :receiver,
                                 :internal, :used, :lost, :used_product, :new_product)
  end
  def item_params_edit
    params.require(:item).permit(:id, :name, :amount, :value, :donor, :receiver,
                                 :internal, :used, :lost, :used_product, :new_product, :created_at)
  end
end
