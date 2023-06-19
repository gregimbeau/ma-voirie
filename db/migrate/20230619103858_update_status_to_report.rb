class UpdateStatusToReport < ActiveRecord::Migration[7.0]
  def change
    remove_column :reports, :status_id
    add_column :reports, :status, :integer, default: 0
  end
end
