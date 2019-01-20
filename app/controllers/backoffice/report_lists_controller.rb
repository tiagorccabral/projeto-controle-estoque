# frozen_string_literal: true

class Backoffice::ReportListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_backoffice_report_list, only: [:show, :edit, :update, :destroy]

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
    respond_to do |format|
      if @backoffice_report_list.save
        # recovers and saves data of sold items
        if params['today_only'] == "1"
          retrieve_sold_items(nil, nil, @backoffice_report_list)
        else
          retrieve_sold_items(backoffice_report_list_params['from_date'],
                              backoffice_report_list_params['to_date'],
                              @backoffice_report_list)
        end
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

  # @param [String] from
  # @param [String] to
  # @param [String] report_list_id
  def retrieve_sold_items(from, to, report_list_id)
    # gathers data only of the current day
    if from == nil and to == nil
      from_time = Time.parse(Date.current.to_s).midnight
      to_time = Time.parse(Date.current.to_s).end_of_day
      soldItemData = SoldItem.where('created_at >= ? AND created_at <= ?',
                                    from_time, to_time)
      if soldItemData != nil
        soldItemData.each do |item|
          puts(report_list_id)
          puts(item.id)
          report_list_id.sold_item << item
          # sold_report_list.report_lists_id = report_list_id
          # sold_report_list.sold_items_id = item.id
          report_list_id.save!
          # itemOb = SoldItem.find_by(id: item.id)
          # itemOb.report_list_ids << report_list_id
        end
      end
      # gathers data from interval of dates (from, to)
    else
      from_time = Time.parse(from.to_s).midnight
      to_time = Time.parse(to.to_s).end_of_day
      soldItemData = SoldItem.where('created_at >= ? AND created_at <= ?',
                                    from_time, to_time)
      if soldItemData != nil
        soldItemData.each do |item|
          sold_report_list = SoldReportList.new
          sold_report_list.report_lists_id = ::ReportList.last.id
          sold_report_list.sold_items_id = item.id
          sold_report_list.save!
        end
      end
    end
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
