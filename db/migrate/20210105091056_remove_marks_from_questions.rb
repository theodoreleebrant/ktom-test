class RemoveMarksFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :marks, :integer
  end
end
