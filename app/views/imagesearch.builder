xml.instruct! :xml, :version => '1.0'
xml.rss :version => "1.0" do
  xml.results do
    @images.each do |image|
      xml.tbUrl image.url
      xml.tbWidth image.width
      xml.tbHeight image.height
    end
  end
end
