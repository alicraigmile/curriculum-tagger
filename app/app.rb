require 'rubygems'
libs = File.expand_path("vendor/bundle/gems/**/lib", __FILE__)
$LOAD_PATH.unshift *Dir.glob(libs)
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

$show_x_latest_relationships = 10

require 'sinatra'
require 'builder'
require 'rack/conneg'

require 'posts'
require 'levels'
require 'images'
require 'relationships'

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


get '/images/?' do
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

get '/levels/?' do
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

get '/levels/:id' do
  @level = Level.find_by(:id => params[:id])
  pass unless @level
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:level => @level}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :level }
    wants.html   {
      content_type :html
      erb :level }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get "/ping" do
    erb :ping, :content_type => 'text/plain'
end

get '/posts/?' do
    @posts = Post.all()
    erb :posts
end

get '/posts/:id' do
    @post = Post.find_by(:id => params[:id])
    pass unless @post
    erb :post
end

get '/relationships/?' do
  @relationships = Relationship.all()
   
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:relationships => @relationships}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :relationships }
    wants.html   {
      content_type :html
      erb :relationships  }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end


get '/relationships/latest/?' do
  show = params[:show] ||= $show_x_latest_relationships
  
  @relationships = Relationship.last(show).reverse
  @latest = true
  @show = show #how many did we ask to return
  @count = @relationships.length #how many did we actually return
   
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:relationships => @relationships}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :relationships }
    wants.html   {
      content_type :html
      erb :relationships  }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get '/relationships/by/object/?' do
  @relationships = Relationship.where(:object => params[:uri])
  @by = params[:by]
  @uri = params[:uri]

  if @by 
    redirect '/relationships/by/' + @by + '/?uri=' + u(params[:uri])
  end
  
  @by = 'object'
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:relationships => @relationships}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :relationships }
    wants.html   {
      content_type :html
      erb :relationships  }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get '/relationships/by/subject/?' do
  @relationships = Relationship.where(:subject => params[:uri])
  @by = params[:by]
  @uri = params[:uri]

  if @by 
    redirect '/relationships/by/' + @by + '/?uri=' + u(params[:uri])
  end
  
  @by = 'subject'
  
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:relationships => @relationships}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :relationships }
    wants.html   {
      content_type :html
      erb :relationships  }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get '/relationships/:id' do
    @relationship = Relationship.find_by_id(params[:id])
    pass unless @relationship
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:relationship => @relationship}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :relationship }
    wants.html   {
      content_type :html
      erb :relationship  }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

post '/relationships/?' do
    rel = Relationship.new()
    rel.subject = params[:subject]
    rel.predicate = params[:predicate]
    rel.object = params[:object]
    begin
      rel.save!
      redirect '/relationships/' + rel.id.to_s
    rescue Exception => e
      error 400, 'Bad Request: ' + e.message
    end
end

get "/version" do
    @version = `git rev-parse --short HEAD`
    erb :version, :content_type => 'text/plain'
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
  def u(text)
    Rack::Utils.escape(text)
  end
  def include(path)
    content = File.read(File.expand_path('views/' + path))
    t = ERB.new(content)
    t.result(binding)
  end
end
