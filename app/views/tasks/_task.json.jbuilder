json.extract! task, :id, :description, :is_completed, :task_status, :created_at, :updated_at
json.url task_url(task, format: :json)
