class BookingsController < ApplicationController

#binding.pry

  def index
    if current_user && Booking.any?
      @bookings = current_user.bookings.where('date >= ?', Date.today)
    end
  end

  def show
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @user = current_user
    @booking_date = Time.zone.parse(params[:booking][:date])
    @booking_slot = params[:booking][:slot]
    # 予約ができる日は本日以降の未来とする
    if @booking_date <  Date.today
      flash[:danger]= "Head for the future!"
      redirect_to new_booking_path and return
    end
    # 日曜（0）か土曜（6）は予約をさせない。→@booking_dateはstring型なのでdate型に変換し、wdayで曜日を出す
    # elsif Date.strptime(@booking_date).wday == 0 || Date.strptime(@booking_date).wday == 6
    if @booking_date.wday == 0 || @booking_date.wday == 6
      flash[:danger]= "Dont' be a slave of your job!"
      redirect_to new_booking_path and return
    end
    #同じ人が同じ日に予約を入れる事を防ぐ…昼食は一日一回であろうと想定
    if Booking.where(user_id: @user.id).where(date: @booking_date).any?
      flash[:danger]= "Double booking in the the day! Please check."
      redirect_to root_path and return
    end
    #同じ日の同じスロットに入る人数の調整…現在はテストとして1人以上予約が入ることを阻止
    if Booking.where(date:@booking_date).where(slot:@booking_slot).count >= 1
      flash[:danger]= "That slot is fully occupied! Please try other slot."
      redirect_to new_booking_path and return
    end
    #うまくいったらとそうでなかったら
    if current_user.bookings.create(booking_params)
      flash[:success]= "Successfully booked"
      redirect_to root_path and return
    else
      flash[:danger]= "Your booking failed"
      redirect_to '/bookings/new' and return
    end
  end# of create

  def edit
    @booking = current_user.bookings.find(params[:id])
  end

  def update
    @user = current_user
    @booking_date = params[:booking][:date]
    @booking_slot = params[:booking][:slot]
    # 予約ができる日は本日以降の未来とする
    if @booking_date <  Date.today.to_s
      flash[:danger]= "Head for the future!"
      redirect_to root_path
    # 日曜（0）か土曜（6）は予約をさせない。→@booking_dateはstring型なのでdate型に変換し、wdayで曜日を出す
    elsif Date.strptime(@booking_date).wday == 0 || Date.strptime(@booking_date).wday == 6
      flash[:danger]= "Dont' be a slave of your job!"
      redirect_to root_path
    else
    #同じ日の同じスロットに入る人数の調整…現在はテストとして1人以上予約が入ることを阻止
      if Booking.where(date:@booking_date).where(slot:@booking_slot).count >= 1
            flash[:danger]= "That slot is fully occupied! Please try other slot."
            redirect_to root_path
      else
        if current_user.bookings.update(booking_params)
          flash[:success]= "Successfully changed!"
          redirect_to '/'
        else
          flash[:danger]= "Your booking changing failed"
          redirect_to '/bookings/new'
        end
      end
    end
  end# of update

  def destroy
    @booking = current_user.bookings.find(params[:id])
    if @booking.destroy
      flash[:success]= "Successfully deleted"
    redirect_to root_path
    else
      flash[:danger]= "Delete failed"
      redirect_to root_path
    end
  end

  private
    def booking_params
      params.require(:booking).permit(:user_id, :date, :slot)
    end

end# of class
