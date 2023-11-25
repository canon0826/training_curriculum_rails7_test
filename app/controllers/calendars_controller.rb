class CalendarsController < ApplicationController
  def index
    get_week # get_weekメソッドから曜日の配列を取得
    @plan = Plan.new
  end

  # 予定の保存
  def create
    @plan = Plan.new(plan_params)
    if @plan.save
    redirect_to action: :index
  else
    # エラーが発生した場合、indexページを再描画してエラーメッセージを表示する
    get_week
    render :index
  end
end

private

def plan_params
  params.require(:plan).permit(:date, :plan)
end
  
  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
  
    @todays_date = Date.today
  
    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)
  
    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      day = @todays_date + x
      days = {
        month: day.month,
        date: day.day,
        plans: today_plans,
        wday: wdays[day.wday]
      }
      @week_days.push(days)
    end
  end
end