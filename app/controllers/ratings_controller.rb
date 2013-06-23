class RatingsController < ApplicationController

def index
  
  @filter = params[:filter]
  unless params[:filter_date].nil?
  @year = params[:filter_date][:year].to_i
  @month = params[:filter_date][:month].to_i
  @day = params[:filter_date][:day].to_i
  @date = DateTime.new(@year, @month, @day)
  
    if @filter == "Year"
      @ratings = Article.all(:conditions => ["created_at >= :start AND created_at <= :end", 
                           {:start => @date.beginning_of_year, :end => @date.end_of_year }]).
                           sort {|b,a| a.num_upvotes <=> b.num_upvotes}
    end
    if @filter == "Month"
      @ratings = Article.all(:conditions => ["created_at >= :start AND created_at <= :end", 
                           {:start => @date.beginning_of_month, :end => @date.end_of_month }]).
                           sort {|b,a| a.num_upvotes <=> b.num_upvotes}
    end
    if @filter == "Day"
      @ratings = Article.all(:conditions => ["created_at >= :start AND created_at <= :end", 
                           {:start => @date.beginning_of_day, :end => @date.end_of_day }]).
                           sort {|b,a| a.num_upvotes <=> b.num_upvotes}
    end



  end
end


end
