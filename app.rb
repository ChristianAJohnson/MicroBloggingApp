require 'sinatra'  
require 'sinatra/activerecord'  
set :database, 'sqlite3:foodreviews.sqlite3'  
require './models'  

set :sessions, true

def current_user
	if(session[:user_id])
		@current_user = User.find(session[:user_id])	
	end
end

get "/display"  do
@users = User.all
erb :"users/display"	
end

get "/feed" do
@posts = Post.all
erb :"users/feed"
end

get "/signup" do
erb :"users/signup"
end

get "/login" do
erb :"users/login"
end

post "/create" do
User.create(name: params[:name], password: params[:password])
redirect "/display"
end

post "/login" do

end



