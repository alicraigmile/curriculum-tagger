xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.formats do 
    @formats.each do |format|
      xml.format do 
        xml.label format.label
        xml.id format.id
        xml.href "/formats/#{format.id}.xml"
      end
    end
  end
  xml.alternates do
    xml.alternate do
      xml.format 'text/html'
      xml.href '/formats' 
    end
    xml.alternate do
      xml.format 'application/json'
      xml.href '/formats.json' 
    end
  end 
end
