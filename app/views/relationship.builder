xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.relationship do 
    xml.id @relationship.id
    xml.subject @relationship.subject
    xml.predicate @relationship.predicate
    xml.object @relationship.object
    xml.created_at @relationship.created_at
    xml.updated_at @relationship.updated_at
  end
  xml.alternates do
    xml.alternate do
      xml.format 'text/html'
      xml.href '/relationships/'+@relationship.id.to_s+'.html' 
    end
    xml.alternate do
      xml.format 'application/json'
      xml.href '/relationships/'+@relationship.id.to_s+'.json' 
    end
  end 
end
