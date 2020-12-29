# frozen_string_literal: true

class AddNameToContests < ActiveRecord::Migration[6.0]
  def change
    add_column :contests, :name, :string
  end
end
