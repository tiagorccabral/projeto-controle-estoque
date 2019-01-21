json.set! :data do
  json.array! @backoffice_report_lists do |backoffice_report_list|
    json.partial! 'backoffice_report_lists/backoffice_report_list', backoffice_report_list: backoffice_report_list
    json.url  "
              #{link_to 'Show', backoffice_report_list }
              #{link_to 'Edit', edit_backoffice_report_list_path(backoffice_report_list)}
              #{link_to 'Destroy', backoffice_report_list, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end