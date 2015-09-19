class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :duration
      t.string :videoId
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
