class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.boolean :validate
      t.string :address
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
