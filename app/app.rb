require 'rubygems'
libs = File.expand_path("vendor/bundle/gems/**/lib", __FILE__)
$LOAD_PATH.unshift *Dir.glob(libs)
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sinatra'
require 'rack/conneg'

require 'posts'

use(Rack::Conneg) { |conneg|
  conneg.set :accept_all_extensions, false
  conneg.set :fallback, :html
  conneg.ignore_contents_of(File.join(File.dirname(__FILE__),'public'))
  conneg.provide([:json, :xml])
}
 
before do
  if negotiated?
    content_type negotiated_type
  end
end
    
get "/" do
    erb :apidocs
end

get '/hello' do
  response = { :message => 'Hello, World!' }
  respond_to do |wants|
    wants.json  { response.to_json         }
    wants.xml   { response.to_xml          }
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
    @post = Post.find_by(id: params[:id])
    pass unless @post
    erb :post
end

get "/version" do
    #@version = '1.0'
    @version = `git rev-parse --short HEAD`
    erb :version, :content_type => 'text/plain'
end
