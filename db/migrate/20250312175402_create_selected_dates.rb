class CreateSelectedDates < ActiveRecord::Migration[8.0]
  def change
    create_table :selected_dates do |t|
      t.string :dateString
      t.datetime :date
      t.integer :numberDay
      t.string :hour
      t.references :schedule, null: false, foreign_key: true
      t.timestamps
    end
  end
end
