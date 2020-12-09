json.extract! question, :id, :question_number, :problem, :answer, :contest_id, :created_at, :updated_at
json.url question_url(question, format: :json)
