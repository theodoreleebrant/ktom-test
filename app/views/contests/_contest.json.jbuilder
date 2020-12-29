# frozen_string_literal: true

json.extract! contest, :id, :is_activated, :created_at, :updated_at
json.url contest_url(contest, format: :json)
