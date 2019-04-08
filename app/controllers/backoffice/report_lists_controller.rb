# frozen_string_literal: true

class Backoffice::ReportListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_backoffice_report_list, only: [:edit, :update, :destroy]

  # GET /backoffice/report_lists
  # GET /backoffice/report_lists.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: ReportListDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /backoffice/report_lists/1
  # GET /backoffice/report_lists/1.json
  def show
    @backoffice_report_list = Backoffice::ReportList.find(params[:id])
    @lost_items = nil
    @sold_items = gather_data(@backoffice_report_list)
    @lost_items = gather_lost_item_data(@backoffice_report_list)
    @total_lost_value = 0.0
    @total_lost_amount = 0
    @total_value = 0
    @total_amount = 0
    @sold_items.each do |sold_item|
      @total_value += sold_item.value
      @total_amount += 1
    end
    @lost_items.each do |lost_item|
      @total_lost_value += lost_item.value
      @total_lost_amount += 1
    end
  end

  # GET /backoffice/report_lists/new
  def new
    @backoffice_report_list = Backoffice::ReportList.new
  end

  # GET /backoffice/report_lists/1/edit
  def edit
  end

  # POST /backoffice/report_lists
  # POST /backoffice/report_lists.json
  def create
    @backoffice_report_list = Backoffice::ReportList.new(backoffice_report_list_params)
    # formats date based on form income
    if params['backoffice_report_list']['today_only'] == "1"
      # @backoffice_report_list.from_date = Time.parse(Date.current.to_s).midnight
      # @backoffice_report_list.to_date = Time.parse(Date.current.to_s).end_of_day
      @backoffice_report_list.from_date = Date.current.to_s
      @backoffice_report_list.to_date = Date.current.to_s
    end
    respond_to do |format|
      if @backoffice_report_list.save
        format.html { redirect_to @backoffice_report_list, notice: 'Relatório de vendas criado com sucesso.' }
        format.json { render :show, status: :created, location: @backoffice_report_list }
      else
        format.html { render :new }
        format.json { render json: @backoffice_report_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backoffice/report_lists/1
  # PATCH/PUT /backoffice/report_lists/1.json
  def update
    respond_to do |format|
      if @backoffice_report_list.update(backoffice_report_list_params)
        format.html { redirect_to @backoffice_report_list, notice: 'Relatório de vendas editado com sucesso.' }
        format.json { render :show, status: :ok, location: @backoffice_report_list }
      else
        format.html { render :edit }
        format.json { render json: @backoffice_report_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backoffice/report_lists/1
  # DELETE /backoffice/report_lists/1.json
  def destroy
    @backoffice_report_list.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_report_lists_url, notice: 'Relatório de vendas deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  # @param [Object] from
  def gather_data(report_list)
    from_date = Time.parse(report_list.from_date.to_s).midnight
    to_date = Time.parse(report_list.to_date.to_s).end_of_day
    sold_items = SoldItem.where("created_at >= ? AND created_at <= ?", from_date,
                                to_date)
    sold_items
  end

  def gather_lost_item_data(report_list)
    from_date = Time.parse(report_list.from_date.to_s).midnight
    to_date = Time.parse(report_list.to_date.to_s).end_of_day
    lost_items = LostItem.where("created_at >= ? AND created_at <= ?", from_date,
                                to_date)
    lost_items
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_backoffice_report_list
    @backoffice_report_list = Backoffice::ReportList.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def backoffice_report_list_params
    params.require(:backoffice_report_list).permit(:name, :from_date, :to_date)
  end
end
