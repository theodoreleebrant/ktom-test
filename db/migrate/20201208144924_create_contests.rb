# frozen_string_literal: true

class CreateContests < ActiveRecord::Migration[6.0]
  def change
    create_table :contests do |t|
      t.boolean :is_activated

      t.timestamps
    end
  end
end
