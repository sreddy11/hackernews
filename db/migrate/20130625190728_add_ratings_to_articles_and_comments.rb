class AddRatingsToArticlesAndComments < ActiveRecord::Migration
  def change
    add_column :articles, :rating, :integer, :null => false, :default => 0  
    add_column :comments, :rating, :integer, :null => false, :default => 0  
  
    add_index :articles, :rating
    add_index :comments, :rating  
  end

end
