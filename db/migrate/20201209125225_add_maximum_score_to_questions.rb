class AddMaximumScoreToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :maximum_score, :integer
  end
end
