class Booking < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :date,    presence: true
  validates :slot,    presence: true
  # validate :slot_limit
  default_scope -> {order(date: :asc)}

  # def slot_limit
  #   binding.pry
  #   @booking_date = params[:booking][:date]
  #   @booking_slot = params[:booking][:slot]
  #   @bookings = Booking.where(date:@booking_date).where(slot:@booking_slot)
  #   if @bookings.count > 1
  #     errors.add(:base, 'That slot is fully occupied! Please try other slot.')
  #   end
  #
  # end

end
