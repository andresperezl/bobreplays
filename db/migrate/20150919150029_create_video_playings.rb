class CreateVideoPlayings < ActiveRecord::Migration
  def change
    create_table :video_playings do |t|
      t.references :video, index: true, foreign_key: true
      t.datetime :start_time

      t.timestamps null: false
    end
  end
end
