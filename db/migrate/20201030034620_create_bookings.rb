class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.datetime :date
      t.string :slot
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    #add_index :bookings, [:user_id]
  end
end
