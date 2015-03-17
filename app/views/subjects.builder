xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.subjects do 
    @subjects.each do |subject|
      xml.subject do 
        xml.label subject.label
        xml.id subject.id
        xml.href "/subjects/#{subject.id}.xml"
        xml.bitesize_url "http://www.bbc.co.uk/education/subjects/#{subject.id}"
      end
    end
  end
  xml.alternates do
    xml.alternate do
      xml.format 'text/html'
      xml.href '/subjects' 
    end
    xml.alternate do
      xml.format 'application/json'
      xml.href '/subjects.json' 
    end
  end 
end
