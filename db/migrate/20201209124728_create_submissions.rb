# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :question_id
      t.string :answer
      t.integer :marks

      t.timestamps
    end
  end
end
