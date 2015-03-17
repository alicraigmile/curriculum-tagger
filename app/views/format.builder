xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.format do 
    xml.id @format.id
    xml.label @format.label
    xml.description @format.description
  end
  xml.alternates do
    xml.alternate do
      xml.format 'text/html'
      xml.href '/formats/'+@format.id+'.html' 
    end
    xml.alternate do
      xml.format 'application/json'
      xml.href '/formats/'+@format.id+'.json' 
    end
  end 
end
