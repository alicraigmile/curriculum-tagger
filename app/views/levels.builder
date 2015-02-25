xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.levels do 
    @levels.each do |level|
      xml.level do 
        xml.label level.label
        xml.id level.id
        xml.href "/levels/#{level.id}"
        xml.bitesize_url "http://www.bbc.co.uk/education/levels/#{level.id}"
      end
    end
  end
  xml.alternates do
    xml.alternate do
      xml.format 'text/html'
      xml.href '/levels' 
    end
    xml.alternate do
      xml.format 'application/json'
      xml.href '/levels.json' 
    end
  end 
end
