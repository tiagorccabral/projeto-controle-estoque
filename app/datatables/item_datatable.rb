class ItemDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :backoffice_sell_item_path
  def_delegator :@view, :edit_backoffice_item_path
  def_delegator :@view, :backoffice_item_path
  def_delegator :@view, :number_to_currency

  def view_columns
    @view_columns ||= {
      id: { source: "Item.id", cond: :like, searchable: true, orderable: true },
      name: { source: "Item.name", cond: :like, searchable: true, orderable: true },
      value: { source: "Item.value", cond: :like, searchable: true, orderable: true },
      amount: { source: "Item.amount", cond: :like, searchable: true, orderable: true },
      donor: { source: "Item.donor", cond: :like, searchable: true, orderable: true },
      receiver: { source: "Item.receiver", cond: :like, searchable: true, orderable: true },
      internal: { source: "Item.internal", cond: :like, searchable: true, orderable: true },
      created_at: { source: "Item.created_at", cond: :like, date_range: true, searchable: true, orderable: true }
    }
  end

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def data
    records.map do |record|
      {
        id: id_as_code(record.id),
        name: record.name,
        value: number_to_currency(record.value, :unit => "R$ ", :separator => ",", :delimiter => "."),
        amount: record.amount,
        donor: record.donor,
        receiver: record.receiver,
        internal: record.internal,
        created_at: record.created_at,
        sell_item: link_to("-", backoffice_sell_item_path(id: record.id), method: "put", data: {confirm: "Tem certeza?"}, class: "btn btn-info"),
        information: link_to("Informações", backoffice_item_path(record), class: "text-info"),
        edit: link_to("Editar", edit_backoffice_item_path(record), class: "text-primary"),
        delete: link_to("Deletar", backoffice_item_path(record), method: "delete", data: {confirm: "Tem certeza?"}, class: "text-danger"),
        DT_RowId:   record.id
      }
    end
  end

  def get_raw_records
    Item.all
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
