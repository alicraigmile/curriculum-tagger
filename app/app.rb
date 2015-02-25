require 'rubygems'
libs = File.expand_path("vendor/bundle/gems/**/lib", __FILE__)
$LOAD_PATH.unshift *Dir.glob(libs)
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require 'sinatra'
require 'builder'
require 'rack/conneg'

require 'posts'
require 'levels'
require 'images'

use(Rack::Conneg) { |conneg|
  conneg.set :accept_all_extensions, false
  conneg.set :fallback, :html
  conneg.ignore_contents_of(File.join(File.dirname(__FILE__),'public'))
  conneg.provide([:json, :xml, :html, :text])
}
 
before do
  headers['Access-Control-Allow-Origin'] = '*'
end
    
get "/" do
    erb :apidocs
end

get '/hello' do
  response = { :message => 'Hello, World!' }
  respond_to do |wants|
    wants.json  { 
      content_type :json
      response.to_json
    }
    wants.xml   { response.to_xml          }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end


get '/images' do
  # matches "GET /images"
  @images = Image.all()
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:images => @images}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :images }
    wants.html   {
      content_type :html
      erb :images  }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get '/images/search' do
  # matches "GET /images/search?q=volcanos"
  #@images = {:responseData => {:results => [{:tbWidth => 56, :tbHeight => 48, :tbUrl => 'http://localhost:9292/images/document.svg'}]}}
  @images = Image.find(:title => params['q'])
  @query = params['q']
    
  respond_to do |wants|
    wants.json  {
      content_type :json
    {:results => @images, :query => @query}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :imagesearch }
    wants.html   {
      content_type :html
      erb :imagesearch }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get '/levels' do
  # matches "GET /levels"
  @levels = Level.all
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:levels => @levels}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :levels }
    wants.html   {
      content_type :html
      erb :levels }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
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
