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


#All my Posts are below

post "/create" do
	User.create(name: params[:name], password: params[:password])
	redirect "/display"
end

post "/login" do
	user = User.where(name: params[:name]).first
	if user.password = params[:password] && user.name = params[:name]
		session[:user_id] = user.id
		redirect "/feed"
	else
		redirect "/login"
	end
end

post "/logout" do
	session[:user_id] = nil
	redirect "/login"
end




