json.set! :data do
  json.array! @lost_items do |lost_item|
    json.partial! 'lost_items/lost_item', lost_item: lost_item
    json.url  "
              #{link_to 'Show', lost_item }
              #{link_to 'Edit', edit_lost_item_path(lost_item)}
              #{link_to 'Destroy', lost_item, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end