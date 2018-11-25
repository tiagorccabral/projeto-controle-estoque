# frozen_string_literal: true

class Backoffice::TimeChartsController < ApplicationController
  before_action :authenticate_user!
  before_action  :set_time_chart, only: [:show, :edit, :destroy]

  # GET /time_charts
  # GET /time_charts.json
  def index
    @time_charts = TimeChart.all.order('created_at DESC')
  end

  # GET /time_charts/1
  # GET /time_charts/1.json
  def show; end

  # GET /time_charts/new
  def new
    @time_chart = TimeChart.new
  end

  # GET /time_charts/1/edit
  def edit; end

  # POST /time_charts
  # POST /time_charts.json
  def create
    @time_chart = TimeChart.new(time_chart_params)

    amount_donated = item_amount_calculator(params['report_date'])
    value_donated = item_value_calculator(params['report_date'])
    @time_chart.report_date = params['report_date']
    @time_chart.amount_donated = amount_donated
    @time_chart.value_donated = value_donated

    respond_to do |format|
      if @time_chart.save
        format.html { redirect_to backoffice_time_charts_path, notice: 'Relatório temporal criado com sucesso.' }
        format.json { render :show, status: :created, location: @time_chart }
      else
        format.html { render :new }
        format.json { render json: @time_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_charts/1
  # PATCH/PUT /time_charts/1.json
  def update
    @time_chart = TimeChart.find(params[:id])

    amount_donated = item_amount_calculator(params['report_date'])
    value_donated = item_value_calculator(params['report_date'])
    @time_chart.report_date = params['report_date']
    @time_chart.amount_donated = amount_donated
    @time_chart.value_donated = value_donated

    respond_to do |format|
      if @time_chart.update(time_chart_params)
        format.html { redirect_to backoffice_time_charts_path, notice: 'Relatório temporal editado com sucesso.' }
        format.json { render :show, status: :ok, location: @time_chart }
      else
        format.html { render :edit }
        format.json { render json: @time_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_charts/1
  # DELETE /time_charts/1.json
  def destroy
    @time_chart.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_time_charts_url, notice: 'Relatório deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Return the value of all donations up until the date provided by the param
  def item_value_calculator(date)
    items = Item.where("created_at <= ?", date)
    value = 0.0
    items.each do |item|
      value += (item.amount * item.value)
    end
    value
  end

  # Return the amount of all donations up until the date provided by the param
  def item_amount_calculator(date)
    items = Item.where("created_at <= ?", date)
    amount = 0
    items.each do |item|
      amount += item.amount
    end
    amount
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_time_chart
    @time_chart = TimeChart.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def time_chart_params
    params.require(:time_chart).permit(:id, :name, :amount_donated,
                                       :report_date, :value_donated)
  end
end
