class ChangeUrls < ActiveRecord::Migration
  def change
  	change_table :urls do |t|
	  t.integer :click_count
	end
  end
end
