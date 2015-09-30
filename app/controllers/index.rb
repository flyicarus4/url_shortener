get '/' do
  @aunty = params[:aunty]
  puts @aunty
  # Look in app/views/index.erb
  erb :index
end

post '/aunty' do
  speech = params[:user_input]
  redirect to("/?aunty=#{speech}")
end
