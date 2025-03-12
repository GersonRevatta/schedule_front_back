class CreateSchedules < ActiveRecord::Migration[8.0]

  def change
    create_table :schedules do |t|
      t.datetime :startDate
      t.datetime :endDate
      t.timestamps
    end
  end
end
