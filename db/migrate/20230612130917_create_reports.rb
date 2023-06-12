class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.boolean :is_validate
      t.string :address
      t.belongs_to :user, index:true
      t.belongs_to :status, index:true

      t.timestamps
    end
  end
end
