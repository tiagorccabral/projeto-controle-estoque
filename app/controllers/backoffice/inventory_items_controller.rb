class Backoffice::InventoryItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]

  # GET /inventory_items
  # GET /inventory_items.json
  def index
    @inventory_items = InventoryItem.all
    @total_amount = 0
    @total_current_value = 0.0
    @total_value = 0.0
    @inventory_items.each do |inventory_item|
      @total_amount += 1
      @total_current_value += inventory_item.current_value
      @total_value += inventory_item.value
    end
  end

  # GET /inventory_list
  def inventory_list
    @inventory_items = InventoryItem.all.order('updated_at DESC')
    respond_to do |format|
      format.html
      format.json { render json: InventoryItemDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /inventory_items/1
  # GET /inventory_items/1.json
  def show
  end

  # GET /inventory_items/new
  def new
    @inventory_item = InventoryItem.new
  end

  # GET /inventory_items/1/edit
  def edit
  end

  # POST /inventory_items
  # POST /inventory_items.json
  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    puts(params)

    respond_to do |format|
      if @inventory_item.save
        format.html { redirect_to backoffice_inventory_list_path, notice: 'Bem de patrimônio criado com sucesso.' }
        format.json { render :show, status: :created, location: @inventory_item }
      else
        format.html { render :new, notice: 'Algo de errado aconteceu.' }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_items/1
  # PATCH/PUT /inventory_items/1.json
  def update
    respond_to do |format|
      if @inventory_item.update(inventory_item_params)
        format.html { redirect_to backoffice_inventory_list_path, notice: 'Bem de patrimônio atualizado com sucesso.'}
        format.json { render :show, status: :ok, location: @inventory_item }
      else
        format.html { render :edit, notice: 'Algo de errado aconteceu.' }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_items/1
  # DELETE /inventory_items/1.json
  def destroy
    @inventory_item.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_inventory_list_path, notice: 'Bem de patrimônio deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_inventory_item
    @inventory_item = InventoryItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inventory_item_params
    params.require(:inventory_item).permit(:id, :name, :code, :responsible,
                                           :area, :acquisition_mode, :conservation_state,
                                           :serial_number, :model,
                                           :storage_location, :age,
                                           :value, :lifespan, :current_value,
                                           :date_of_acquisition, :depreciation,
                                           :category_ids)
  end
end
