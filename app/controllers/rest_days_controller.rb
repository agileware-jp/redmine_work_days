class RestDaysController < ApplicationController
  before_filter :require_admin
  before_filter :get_year

  unloadable

  def index
    @rest_day = RestDay.new
    @rest_days = RestDay.in_year(@year).all

    @rest_day_csv = RestDayCsv.new
    @rest_day_range = RestDayRange.new
  end

  def create
    @rest_day = RestDay.new(params[:rest_day])
    if @rest_day.save
      RestDay.clear!
      redirect_to rest_days_path, :notice => l(:notice_create_rest_day_success)
    else
      redirect_to rest_days_path, :alert => l(:alert_create_rest_day_failure)
    end
  end

  def import
    @rest_day_csv = RestDayCsv.new(params[:rest_day_csv])

    if @rest_day_csv.file.present? && @rest_day_csv.valid?
      begin
        @rest_day_csv.import_from_csv!
        RestDay.clear!
      rescue => e
        flash[:error] = e.message
        redirect_to rest_days_path
        return
      end
      redirect_to rest_days_path, :notice => l(:notice_import_rest_days_success, :count => @count)
    else
      @rest_days = RestDay.in_year(@year).all
      @rest_day_range = RestDayRange.new
      render :action => "index"
    end
  end

  def range_delete
    @rest_day_range = RestDayRange.new(params[:rest_day_range])

    if @rest_day_range.valid?
      @rest_days = RestDay.between(@rest_day_range.from, @rest_day_range.to)
      @count = @rest_days.count
      @rest_days.destroy_all
      RestDay.clear!
      redirect_to rest_days_path, :notice => l(:notice_delete_rest_days_success, :count => @count)
    else
      @rest_day = RestDay.new
      @rest_day_csv = RestDayCsv.new
      @rest_days = RestDay.in_year(@year).all
      render :action => "index"
    end
  end

  private
  def get_year
    if session[:year].present? and params[:year].blank?
      @year = session[:year]
    else
      @year = params[:year].present? ? Date.new(params[:year].to_i, 1, 1) : Date.today
      session[:year] = @year
    end
  end
end
