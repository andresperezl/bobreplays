class CreateVoteCounts < ActiveRecord::Migration
  def change
    create_table :vote_counts do |t|
      t.references :video, index: true, foreign_key: true
      t.integer :count, default: 0
      t.date :last_win_at
    end
    create_table :votes do |t|
      t.references :video, index: true, foreign_key: true
      t.string :username
    end
  end
end
