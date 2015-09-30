class Url < ActiveRecord::Base
  validates :long_url, presence: true
  validates :long_url, uniqueness:true
  validates :long_url, format: { with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix ,  message: "The input string is not a valid URL"}
  validates :long_url, length: { minimum: 4 }
	validates :unique_key, uniqueness: true
  before_save :shorten
  # Remember to create a migration!
  def shorten
    #use find_or_initialize to confirm uniqueness of long_url
  	self.unique_key = generate_unique_key
    self.click_count = 0
    #update unique key of row
    # row.update(unique_key: generate_unique_key, click_count: 0) if row.unique_key == nil
  end

  def generate_unique_key
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

  def self.validate_input(input)
    row = Url.new(long_url: input)
    row.valid?
    p "[ERROR MESSAGES ON VALIDATION]"
    p row.errors.messages
    row.errors.messages
  end
end
