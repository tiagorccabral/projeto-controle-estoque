class CategoryDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_backoffice_category_path
  def_delegator :@view, :backoffice_category_path

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Category.id", cond: :eq },
      name: { source: "Category.name", cond: :like, searchable: true, orderable: true },
      category_user: { source: "Category.inventory_items", orderable: false },
      created_at: { source: "Category.created_at", cond: :like, date_range: true, orderable: true }
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
        created_at: record.created_at,
        category_use: record.inventory_items.count,
        information: link_to("Informações", backoffice_category_path(record), class: "text-info"),
        edit: link_to("Editar", edit_backoffice_category_path(record), class: "text-primary"),
        delete: link_to("Deletar", backoffice_category_path(record), method: "delete", data: {confirm: "Tem certeza?"}, class: "text-danger"),
        DT_RowId:   record.id
      }
    end
  end

  def get_raw_records
    Category.all
  end

end
