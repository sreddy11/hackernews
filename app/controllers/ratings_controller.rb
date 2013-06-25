class RatingsController < ApplicationController

  
  def index
    
    if parse_search
      case @filter
      when "Year"
        @ratings = Article.by_year(@date)
        @search_string = @date.strftime('%Y') 
      when "Month"
        @ratings = Article.by_month(@date)
        @search_string = @date.strftime('%b %Y')
      when "Day"
        @ratings = Article.by_day(@date) 
        @search_string = @date.strftime('%b %d %Y')
      end
    end
  end

  private

  def parse_search
    @filter = params[:filter] || "Day"
    if !params[:filter_date].nil?
      @filter_date = params[:filter_date]
      #@year = params[:filter_date][:year].to_i
      #@month = params[:filter_date][:month].to_i
      #@day = params[:filter_date][:day].to_i
      @date = DateTime.new(@filter_date[:year].to_i, @filter_date[:month].to_i, @filter_date[:day].to_i)
      true
    else
      @date = Date.today
      @search_string = @date.strftime('%b %d %Y')
      false
    end
  end
end
