class AddUploadedOnToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :uploaded_on, :date
  end
end
