class CalendarsController < ApplicationController
  def index
    @week_days = getWeek # getWeekメソッドから曜日の配列を取得
    get_week
    @plan = Plan.new
  end
  
  private
  
  def plan_params
    params.require(:calendars).permit(:date, :plan)
  end


  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
  
    @todays_date = Date.today
  
    week_days = []
  
    7.times do |x|
      days = {
        month: (@todays_date + x).month,
        date: (@todays_date + x).day,
        plans: [],
        wday: wdays[(@todays_date + x).wday]
      }
      week_days.push(days)
    end

    week_days
  end
end