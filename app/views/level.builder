xml.instruct! :xml, :version => '1.0'
xml.results :version => "1.0" do
  xml.level do 
    xml.id @level.id
    xml.label @level.label
    xml.description @level.description
  end
  xml.alternates do
    xml.alternate do
      xml.format 'text/html'
      xml.href '/levels/'+@level.id+'.html' 
    end
    xml.alternate do
      xml.format 'application/json'
      xml.href '/levels/'+@level.id+'.json' 
    end
  end 
end
