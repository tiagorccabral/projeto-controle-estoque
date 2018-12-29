class InventoryItemDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_backoffice_inventory_item_path
  def_delegator :@view, :backoffice_inventory_item_path
  def_delegator :@view, :number_to_currency

  def view_columns
    @view_columns ||= {
      id: { source: "InventoryItem.id", cond: :eq },
      name: { source: "InventoryItem.name", cond: :like, searchable: true, orderable: true },
      code: { source: "InventoryItem.code", cond: :like, searchable: true, orderable: true },
      value: { source: "InventoryItem.value", cond: :eq, searchable: true, orderable: true },
      model: { source: "InventoryItem.model", cond: :like, searchable: true, orderable: true },
      date_of_acquisition: { source: "InventoryItem.date_of_acquisition",
                             cond: :like, date_range: true, orderable: true }
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
        code: record.code,
        value: number_to_currency(record.value, :unit => "R$ ", :separator => ",", :delimiter => "."),
        model: record.model,
        date_of_acquisition: record.date_of_acquisition,
        information: link_to("Informações", backoffice_inventory_item_path(record), class: "text-info"),
        edit: link_to("Editar", edit_backoffice_inventory_item_path(record), class: "text-primary"),
        delete: link_to("Deletar", backoffice_inventory_item_path(record), method: "delete", data: {confirm: "Tem certeza?"}, class: "text-danger"),
        DT_RowId:   record.id
      }
    end
  end

  def get_raw_records
    InventoryItem.all
  end

end
