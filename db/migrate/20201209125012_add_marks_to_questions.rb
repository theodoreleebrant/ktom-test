# frozen_string_literal: true

class AddMarksToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :marks, :integer
  end
end
