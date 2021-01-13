class AddTimeframeIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :timeframe_id, :string
  end
end
