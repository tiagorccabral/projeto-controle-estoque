json.extract! backoffice_report_list, :id, :name, :from_date, :to_date, :created_at, :updated_at
json.url backoffice_report_list_url(backoffice_report_list, format: :json)
