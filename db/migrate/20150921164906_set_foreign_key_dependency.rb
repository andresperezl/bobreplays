class SetForeignKeyDependency < ActiveRecord::Migration
  def change
    remove_column :vote_counts, :video_id
    remove_column :votes, :video_id
    remove_column :video_playings, :video_id

    add_column :vote_counts, :video_id, :integer
    add_column :votes, :video_id, :integer
    add_column :video_playings, :video_id, :integer

    add_foreign_key :vote_counts, :videos, on_delete: :cascade
    add_foreign_key :votes, :videos, on_delete: :cascade
    add_foreign_key :video_playings, :videos, on_delete: :cascade
  end
end
