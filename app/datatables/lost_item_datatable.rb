class LostItemDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :backoffice_lost_item_path
  def_delegator :@view, :number_to_currency

  def view_columns
    @view_columns ||= {
      id: { source: "LostItem.id", cond: :like, searchable: true, orderable: true },
      name: { source: "LostItem.name", cond: :like, searchable: true, orderable: true },
      code: { source: "LostItem.code", cond: :like, searchable: true, orderable: true },
      value: { source: "LostItem.value", cond: :like, searchable: true, orderable: true },
      status: { source: "LostItem.status", cond: :like, orderable: true },
      created_at: { source: "LostItem.created_at", cond: :like, date_range: true, searchable: true, orderable: true }
    }
  end

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def data
    records.map do |record|
      {
        code: id_as_code(record.code),
        name: record.name,
        status: status_to_string(record.status),
        value: number_to_currency(record.value, :unit => "R$ ", :separator => ",", :delimiter => "."),
        information: link_to("Informações", backoffice_lost_item_path(record), class: "text-info"),
        created_at: record.created_at
      }
    end
  end
  
  def get_raw_records
    LostItem.all
  end

  def id_as_code(id)
    idString = id.to_s
    if idString.length == 1
      return "00000#{id}"
    elsif idString.length == 2
      return "0000#{id}"
    elsif idString.length == 3
      return "000#{id}"
    elsif idString.length == 4
      return "00#{id}"
    elsif idString.length == 5
      return "0#{id}"
    else
      return id
    end
  end

  def status_to_string(status)
    if status == "stolen"
      return "Furto"
    elsif status == "deterioration"
      return "Deterioração"
    elsif status == "donation"
      return "Doação"
    elsif status == "other"
      return "Outro"
    end
  end

end
