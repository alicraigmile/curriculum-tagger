require 'rubygems'
require 'git-version-bump'
libs = File.expand_path("vendor/bundle/gems/**/lib", __FILE__)
$LOAD_PATH.unshift *Dir.glob(libs)
$LOAD_PATH.unshift File.dirname(__FILE__) + '/'

$show_x_latest_relationships = 10

require 'sinatra'
require 'builder'
require 'rack/conneg'

require 'curriculum-tagger/posts'
require 'curriculum-tagger/levels'
require 'curriculum-tagger/images'
require 'curriculum-tagger/formats'
require 'curriculum-tagger/relationships'
require 'curriculum-tagger/subjects'
require 'curriculum-tagger/version'

use(Rack::Conneg) { |conneg|
  conneg.set :accept_all_extensions, false
  conneg.set :fallback, :html
  conneg.ignore_contents_of(File.join(File.dirname(__FILE__),'../public'))
  conneg.provide([:json, :xml, :html, :text])
}

set :root, File.join(File.dirname(__FILE__),'../')
 
before do
  headers['Access-Control-Allow-Origin'] = '*'
end
    
get "/" do
    erb :apidocs
end


get '/formats/?' do
  # matches "GET /formats
  @formats = CurriculumTagger::Format.all
   
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:formats => @formats}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :formats }
    wants.html   {
      content_type :html
      erb :formats }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get '/formats/:id' do
  @format = CurriculumTagger::Format.find_by(:id => params[:id])
  pass unless @format
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:format => @format}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :format }
    wants.html   {
      content_type :html
      erb :format }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
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
  @images = CurriculumTagger::Image.all()
    
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
  @images = CurriculumTagger::Image.find(:title => params['q'])
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
  @levels = CurriculumTagger::Level.all
    
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
  @level = CurriculumTagger::Level.find_by(:id => params[:id])
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
    @posts = CurriculumTagger::Post.all()
    erb :posts
end

get '/posts/:id' do
    @post = CurriculumTagger::Post.find_by(:id => params[:id])
    pass unless @post
    erb :post
end

get '/relationships/?' do
  @relationships = CurriculumTagger::Relationship.all()
   
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
  
  @relationships = CurriculumTagger::Relationship.last(show).reverse
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

get '/relationships/new' do
  @subject = params[:s]
  @predicate = params[:p]
  @object = params[:o]

  erb :new_relationship
end


get '/relationships/by/?' do 
  @by = params[:by]
   
  #if ?by querystring exists and in non-empty the form is sending back a value
    #for us to build a url from (seen next endpoint)
  if @by && ! @by.empty?
    halt 400 unless ['subject','predicate','object'].include?(@by)    
    redirect '/relationships/by/' + @by + '/?uri=' + u(params[:uri])    
  end

  #otherwise we want to search by uri in '-any-' field
  @uri = params[:uri]
  halt 400 unless @uri
  
  @relationships = CurriculumTagger::Relationship.where("subject = ? OR predicate = ? OR object = ?", @uri, @uri, @uri)

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


get '/relationships/by/:by/?' do  
  @by = params[:by]

  halt 400 unless ['subject','predicate','object'].include?(@by)
  
  @relationships = CurriculumTagger::Relationship.where(@by => params[:uri])
  @uri = params[:uri]
    
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


delete '/relationships/:id' do

  begin
    CurriculumTagger::Relationship.destroy(params[:id])
    redirect '/relationships/latest/', 303
  rescue Exception => e
    error 400, 'Bad Request: ' + e.message
    redirect '/relationships/' + rel.id.to_s
  end
end

get '/relationships/:id' do
    @relationship = CurriculumTagger::Relationship.find_by_id(params[:id])
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

put '/relationships/:id' do
  rel = CurriculumTagger::Relationship.find_by_id(params[:id])
  pass unless rel
  
  rel.subject = params[:s]
  rel.predicate = params[:p]
  rel.object = params[:o]
  begin
    rel.save!
    redirect '/relationships/' + rel.id.to_s
  rescue Exception => e
    error 400, 'Bad Request: ' + e.message
  end
    
end

get '/relationships/:id/edit' do
    @relationship = CurriculumTagger::Relationship.find_by_id(params[:id])
    pass unless @relationship
    erb :edit_relationship
end

post '/relationships/?' do
    rel = CurriculumTagger::Relationship.new()
    rel.subject = params[:s]
    rel.predicate = params[:p]
    rel.object = params[:o]
    begin
      rel.save!
      redirect '/relationships/' + rel.id.to_s
    rescue Exception => e
      error 400, 'Bad Request: ' + e.message
    end
end

get '/subjects/?' do
  # matches "GET /subjects
  @subjects = CurriculumTagger::Subject.all
   
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:subjects => @subjects}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :subjects }
    wants.html   {
      content_type :html
      erb :subjects }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get '/subjects/:id' do
  @subject = CurriculumTagger::Subject.find_by(:id => params[:id])
  pass unless @subject
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:subject => @subject}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :subject }
    wants.html   {
      content_type :html
      erb :subject }
    wants.other { 
      content_type 'text/plain'
      error 406, "Not Acceptable" 
    }
  end
end

get "/version" do
  @version = CurriculumTagger::VERSION
    
  respond_to do |wants|
    wants.json  {
      content_type :json
      {:version => @version}.to_json
    }
    wants.xml   {
      content_type :xml
      builder :version }
    wants.other { 
      erb :version, :content_type => 'text/plain'
    }
  end  
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
  def u(text)
    Rack::Utils.escape(text)
  end
  def p(text)
      if (text && !text.empty?)
        '/' + text 
      else
        ''
      end
  end
  def include(path)
    content = File.read(File.expand_path(File.join(File.dirname(__FILE__), '../views/' + path)))
    t = ERB.new(content)
    t.result(binding)
  end
end

not_found do
  status 404
  erb :oops
end


error 400 do
  erb :bad_request
end
