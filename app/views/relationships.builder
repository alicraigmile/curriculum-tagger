xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.relationships do 
    @relationships.each do |rel|
      xml.relationship do 
        xml.id rel.id
        xml.subject rel.subject
        xml.predicate rel.predicate
        xml.object rel.object
        xml.created_at rel.created_at
        xml.updated_at rel.updated_at
      end
    end
  end
  case @by
  when nil
    xml.alternates do
      xml.alternate do
        xml.format 'text/html'
        xml.href '/relationships.html' 
      end
      xml.alternate do
        xml.format 'application/json'
        xml.href '/relationships.json' 
      end
    end 
  else
    xml.alternates do
      xml.alternate do
        xml.format 'text/html'
        xml.href '/relationships/by/'+ @by +'.html?uri='  + u(@uri)
      end
      xml.alternate do
        xml.format 'application/json'
        xml.href '/relationships/by/'+ @by +'.json?uri=' + u(@uri)
      end
    end 
  end
end
