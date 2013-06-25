class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :votable_id
      t.string :votable_type
      t.references :user
      t.integer :up_or_down
      t.timestamps
    end
  end
end
