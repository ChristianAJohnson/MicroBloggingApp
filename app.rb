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
	session[:user_id] = nil #this resets the session so that you dont get an error from an already logged in user
	user = User.create(name: params[:name], password: params[:password])
	session[:user_id] = user.id #this sets up the session to the new user
	redirect "/display"
end

post "/login" do
	user = User.where(name: params[:name]).first
	if user.password = params[:password]
		session[:user_id] = user.id
		redirect "/display"
	else
		redirect "/login"
	end
end

post "/logout" do
	session[:user_id] = nil
	redirect "/login"
end

post "/delete" do
	user = User.find(session[:user_id])
	user.destroy
	session[:user_id] = nil
	# if user == nil
	redirect "/signup"
	# end
end

get "/" do 
	@posts = Post.all
	erb :"users/feed"
end

get "/new-post" do 
	erb :"posts/create"
end

post "/posts/create" do 
	if !session[:user_id]
		redirect "/login"
	elsif params[:title] == "" || params[:content] == "" || params[:rating].to_i > 5 || params[:rating].to_i < 1 
		redirect "/new-post"
	else
	logged_in = User.find(session[:user_id])
	Post.create(name: params[:title], content: params[:content], rating: params[:rating].to_i, user_id: logged_in.id)
	redirect "/feed"
	end
end