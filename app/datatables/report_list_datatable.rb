class ReportListDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_backoffice_report_list_path
  def_delegator :@view, :backoffice_report_list_path

  def view_columns
    @view_columns ||= {
        id: { source: "ReportList.id", cond: :like, searchable: true, orderable: true },
        name: { source: "ReportList.name", cond: :like, searchable: true, orderable: true },
        from_date: { source: "ReportList.from_date", cond: :like, date_range: true, searchable: true, orderable: true },
        to_date: { source: "ReportList.to_date", cond: :like, date_range: true, searchable: true, orderable: true }
    }
  end

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def data
    records.map do |record|
      {
          id: record.id,
          name: record.name,
          from_date: record.from_date.strftime("%d/%m/%Y"),
          to_date: record.to_date.strftime("%d/%m/%Y"),
          information: link_to("Informações", backoffice_report_list_path(record), class: "text-info"),
          delete: link_to("Deletar", backoffice_report_list_path(record), method: "delete", data: {confirm: "Tem certeza?"}, class: "text-danger"),
          DT_RowId:   record.id
      }
    end
  end

  def get_raw_records
    ReportList.all
  end

end
