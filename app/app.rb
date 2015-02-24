require 'rubygems'
require 'sinatra'

$:.unshift File.dirname(__FILE__)
require 'posts'
     
get "/" do
    erb :apidocs
end

get '/images/search' do
  # matches "GET /images/search?q=volcanos"
  @images = [{:width => 56, :height => 48, :url => '/images/document.svg'}]
  erb :imagesearch
end

get "/ping" do
    erb :ping, :content_type => 'text/plain'
end

get '/posts' do
    @posts = Post.all()
    erb :posts
end

get '/posts/:id' do
    @post = Post.find_by(:id => params[:id])
    pass unless @post
    erb :post
end

get "/version" do
    #@version = '1.0'
    @version = `git rev-parse --short HEAD`
    erb :version, :content_type => 'text/plain'
end
