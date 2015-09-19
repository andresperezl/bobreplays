class ChangeLastWinAtToDateTime < ActiveRecord::Migration
  def change
    change_column :vote_counts, :last_win_at, :datetime
  end
end
