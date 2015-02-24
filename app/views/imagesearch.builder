xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  @images.each do |image|
    xml.result do 
      xml.tbUrl image[:url]
      xml.tbWidth image[:width]
      xml.tbHeight image[:height]
    end
  end
end
