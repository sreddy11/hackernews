class AddPageNumber < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
    add_column :articles, :page, :integer
  end
end
