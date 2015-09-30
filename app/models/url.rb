class Url < ActiveRecord::Base
	validates :unique_key, uniqueness: true
  # Remember to create a migration!
  def shorten
  	Url.create!(long_url: long_url,unique_key: generate_unique_key)
  end

  def generate_unique_key
  	key = Array.new(n){[*"A".."Z", *"0".."9"].sample}.join
  	while list_all_unique_keys.include?(key)
  		key = Array.new(n){[*"A".."Z", *"0".."9"].sample}.join 		
  	end
  	key 
  end


  def list_all_unique_keys
  	list = []
  	Url.all.each{|row| list << row.unique_key}
  	list
  end
end
