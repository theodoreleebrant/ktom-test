class ChangeDefaultActivationContests < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:contests, :is_activated, false)
  end
end
