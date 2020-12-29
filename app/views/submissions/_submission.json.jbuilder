# frozen_string_literal: true

json.extract! submission, :id, :user_id, :question_id, :answer, :marks, :created_at, :updated_at
json.url submission_url(submission, format: :json)
