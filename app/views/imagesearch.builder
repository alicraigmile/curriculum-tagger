xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  @images.each do |image|
    xml.result do 
      xml.url image.url
      xml.width image.width
      xml.height image.height
      xml.title image.title
    end
  end
  xml.query @query 
end
