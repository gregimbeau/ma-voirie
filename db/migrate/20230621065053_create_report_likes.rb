class CreateReportLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :report_likes do |t|
      t.belongs_to :report, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
