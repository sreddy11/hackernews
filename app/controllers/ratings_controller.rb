class RatingsController < ApplicationController

  def index
    @ratings = Article.in_date_range(start_date, end_date).by_rating
  end
 
 
  private
 
  def filter_type
    params[:filter].downcase || "day"
  end
  helper_method :filter_type
 
  def current_date
    DateTime.new(year,month,day)
  end
  helper_method :current_date
 
  def search_string
    case @filter
    when "year"
      @search_string = @date.strftime('%Y') 
    when "month"
      @search_string = @date.strftime('%b %Y') 
    when "day"
      @search_string = @date.strftime('%b %d %Y') 
    end
  end
  helper_method :search_string
 
 
  def filter_date_params
    [month,day,year]
  end
 
  def start_date
    current_date.send("beginning_of_#{filter_type}")
  end
 
  def end_date
    current_date.send("end_of_#{filter_type}")
  end
 
  def day
    params[:filter_date][:day].to_i unless params[:filter_date].nil?
  end
 
  def month
    params[:filter_date][:month].to_i unless params[:filter_date].nil?
  end
 
  def year
    params[:filter_date][:year].to_i unless params[:filter_date].nil?
  end
end

=begin
  def index
    if parse_search
      set_params
      @ratings = Article.in_date_range(@dat:e,@start,@end).by_rating
    end
  end

  private

  def parse_search
    @filter = params[:filter] || "day"
    if !params[:filter_date].nil?
      @filter_date = params[:filter_date]
      @date = DateTime.new(@filter_date[:year].to_i, @filter_date[:month].to_i, @filter_date[:day].to_i)
      true
    else
      @date = Date.today
      @search_string = @date.strftime('%b %d %Y')
      false
    end
  end

  def set_params
    case @filter
    when "Year"
      @start = @date.beginning_of_year
      @end = @date.end_of_year
      @search_string = @date.strftime('%Y') 
    when "Month"
      @start = @date.beginning_of_month
      @end = @date.end_of_month
      @search_string = @date.strftime('%b %Y') 
    when "Day"
      @start = @date.beginning_of_day
      @end = @date.end_of_day
      @search_string = @date.strftime('%b %d %Y') 
    end
  end
end
=end
