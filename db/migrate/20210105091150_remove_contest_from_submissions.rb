class RemoveContestFromSubmissions < ActiveRecord::Migration[6.0]
  def change
    remove_column :submissions, :contest_id, :integer
  end
end
