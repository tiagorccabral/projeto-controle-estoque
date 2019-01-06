class SoldItemDatatable < AjaxDatatablesRails::ActiveRecord

  extend Forwardable

  def_delegator :@view, :number_to_currency

  def view_columns
    @view_columns ||= {
      id: { source: "SoldItem.id", cond: :like, searchable: true, orderable: true },
      name: { source: "SoldItem.name", cond: :like, searchable: true, orderable: true },
      value: { source: "SoldItem.value", cond: :like, searchable: true, orderable: true },
      amount: { source: "SoldItem.amount", cond: :like, searchable: true, orderable: true },
      code: { source: "SoldItem.code", cond: :like, searchable: true, orderable: true },
      created_at: { source: "SoldItem.created_at", cond: :like, date_range: true, searchable: true, orderable: true },
      updated_at: { source: "SoldItem.updated_at", cond: :like, date_range: true, searchable: true, orderable: true }
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
        value: number_to_currency(record.value, :unit => "R$ ", :separator => ",", :delimiter => "."),
        amount: record.amount,
        created_at: record.created_at,
        updated_at: record.updated_at,
        DT_RowId:   record.id
      }
    end
  end

  def get_raw_records
    SoldItem.all
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

end
