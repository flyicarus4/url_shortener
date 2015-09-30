class Url < ActiveRecord::Base
  validates :long_url, uniqueness:true, format: { with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }
	validates :unique_key, uniqueness: true
  # Remember to create a migration!
  def self.shorten(long_url)
    #use find_or_initialize to confirm uniqueness of long_url
  	row = Url.find_or_initialize_by(long_url: long_url)
    #update unique key of row
    row.update(unique_key: generate_unique_key, click_count: 0) if row.unique_key == nil
  end

  def self.generate_unique_key
  	key = Array.new(6){[*"A".."Z", *"0".."9"].sample}.join
  	while list_all_unique_keys.include?(key)
  		key = Array.new(6){[*"A".."Z", *"0".."9"].sample}.join 		
  	end
  	key 
  end

  def self.list_all_unique_keys
  	list = []
  	Url.all.each{|row| list << row.unique_key}
  	list
  end

  def self.list
    list = []
    Url.all.each{|row| list << [row.long_url ,row.unique_key, row.click_count]}
    list
  end

  def url_validator
  end
end
