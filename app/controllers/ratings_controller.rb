class RatingsController < ApplicationController
  def index
    if parse_search
      set_params
      @ratings = Article.in_date_range(@date,@start,@end).by_rating
    end
  end

  private

  def parse_search
    @filter = params[:filter] || "Day"
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
