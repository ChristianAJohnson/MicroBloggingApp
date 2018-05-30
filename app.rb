require 'sinatra'  
require 'sinatra/activerecord'  
set :database, 'sqlite3:foodreviews.sqlite3'  
require './models'  


get "/display"  do

@users = User.all

erb :"users/display"	
end


get "/feed" do

@posts = Post.all

erb :"users/feed"
end
