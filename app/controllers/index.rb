require_relative '../../config/environment'


get '/' do
  @list = Url.list
  puts "[LOG] Getting /"
  puts "[LOG] Params: #{params.inspect}"
  erb :index
end

post '/urls' do
  # create a new Url
  @url = Url.find_or_initialize_by(long_url: params[:input])
  if @url.save
    redirect to '/'
  else
    @list = Url.list
    erb :index
  end

end

  # i.e. /q6bda
get '/:unique_key' do
  # redirect to appropriate "long" URL
  long = Url.find_by(unique_key: params[:unique_key])
  long.click_count += 1
  long.save
  redirect to("#{long.long_url}")
end
