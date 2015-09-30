require_relative '../../config/environment'

get '/' do
  @list = Url.list
  puts "[LOG] Getting /"
  puts "[LOG] Params: #{params.inspect}"
  erb :index
end

post '/urls' do
  # create a new Url
  long_url = params[:long_url]
  puts "DEBUG: long url is #{params[:long_url]}"
  Url.shorten(long_url)
  unique_key = Url.find_by(long_url: long_url).unique_key
  redirect to("/")
end

  # i.e. /q6bda
get '/:unique_key' do
  # redirect to appropriate "long" URL
  long_url = Url.find_by(unique_key: params[:unique_key]).long_url
  redirect to("#{long_url}")
end
