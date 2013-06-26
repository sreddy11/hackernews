class RatingsController < ApplicationController

  def index
    @ratings = Article.in_date_range(start_date, end_date).by_rating
  end
 
  private
 
  def filter_type
    params[:filter].try(:downcase) || "day"
  end
  helper_method :filter_type
 
  def current_date
    @date ||= DateTime.new(year,month,day)
  end
  helper_method :current_date
 
  def search_string
    
    @search_string ||= case filter_type
    when "year"
      current_date.strftime('%Y') 
    when "month"
      current_date.strftime('%b %Y') 
    when "day"
      current_date.strftime('%b %d %Y') 
    end
  end
  helper_method :search_string
 
 
  def filter_date_params
    params[:filter_date] || {}
  end
 
  def start_date
    current_date.send("beginning_of_#{filter_type}")
  end
 
  def end_date
    current_date.send("end_of_#{filter_type}")
  end
 
  def day
    filter_date_params[:day].try(:to_i) || Date.today.day
  end
 
  def month
    filter_date_params[:month].try(:to_i) || Date.today.month
  end
 
  def year
    filter_date_params[:year].try(:to_i) || Date.today.year
  end
end
