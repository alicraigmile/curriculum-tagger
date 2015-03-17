xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.subject do 
    xml.id @subject.id
    xml.label @subject.label
    xml.description @subject.description
  end
  xml.alternates do
    xml.alternate do
      xml.format 'text/html'
      xml.href '/subjects/'+@subject.id+'.html' 
    end
    xml.alternate do
      xml.format 'application/json'
      xml.href '/subjects/'+@subject.id+'.json' 
    end
  end 
end
