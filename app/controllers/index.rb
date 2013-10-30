require 'faker'

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/create_user' do
  erb :create_user
end

get '/secret/:id' do
  p session[:user_id]
  p params[:id]
  # params[:id] is a string. Convert to int before comparison
  if session[:user_id] == params[:id].to_i
    @user = User.find(params[:id])
    @wisdom = Faker::Company.catch_phrase
    erb :secret
  else
    redirect('/')
  end
end

get '/logout' do
  session.clear
  erb :logout
end


# **************** POSTS ****************

post '/login' do
  @user = User.find_by_user_name(params[:user_name])
  if params[:password] == @user.password
    session[:user_id] = @user.id
    redirect "/secret/#{@user.id}"
  else
    puts "failed"
    redirect '/'
  end
end

post '/create_user' do
  User.create(user_name: params[:user_name], first_name: params[:first_name], 
            last_name: params[:last_name], email: params[:email], password: params[:password] )

  erb :login
end

 
