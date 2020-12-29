# frozen_string_literal: true

class AddContestIdToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :contest_id, :integer
  end
end
