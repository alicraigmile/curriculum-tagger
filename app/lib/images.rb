class Image
  attr_accessor :url, :width, :height, :title

  def initialize (url, width, height, title = nil)
    @url = url
    @width = width
    @height = height
    @title = title
  end
  
  def self.all ()
    [
        Image.new('http://localhost:9292/images/document.svg',48, 56, 'Document'),
        Image.new('http://localhost:9292/images/document.svg', 38, 46, 'Small document')
    ]
  end

  #find (:id => '1')
  #find (:title => '~document')
  def self.find ( query )
    [
      Image.new('http://localhost:9292/images/document.svg',48, 56, 'Document')
    ]      
#    Image.all().any?{|a| a.title == 'Document'}
  end  
end


