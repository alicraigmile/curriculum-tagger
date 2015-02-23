require 'rubygems'
require 'sinatra'

$:.unshift File.dirname(__FILE__)
require 'posts'
     
get "/" do
    erb :apidocs
end

get "/ping" do
    erb :ping
end

get '/posts' do
    @posts = Post.all()
    erb :posts
end

get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    pass unless @post
    erb :post
end

get "/version" do
    @version = '1.0'
    erb :version
end

# creates a new beer with posted parameters and returns the newly created beer as a JSON response.
post "/beers" do
    Beer.create(params[:beer]).to_json
end
     
# finds the beer to be updated, updates beer attributes with the posted parameters and returns the updated beer as a JSON response.
puts "/beers/:id" do
    @beer = Beer.find(params[:id])
    @beer.update_attributes(params[:beer]).to_json
end
     
# finds the beer to be destroyed, destroys it returns a 204 response.
delete "/beers/:id" do
    @beer = Beer.find(params[:id])
    @beer.destroy
    status 204
end
