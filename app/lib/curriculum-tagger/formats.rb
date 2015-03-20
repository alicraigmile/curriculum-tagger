module CurriculumTagger
 
class Format
  attr_accessor :label, :id, :description

  def initialize (label, id = nil, description = nil)
    @label = label
    @id = id
    @description = description
  end


  # A decorator should return this ideally - that way, we'd ensure the hostname featured too
  def uri
    '/formats/' + @id
  end

  
  def self.find_by (options={})
    self.all().find { |format| format.id == options[:id] }
  end

    
  def self.all ()
    [
      Format.new('Index','index'),
      Format.new('Revision bite','revision-bite'),
      Format.new('Activity','activity'),
      Format.new('Video','video'),
      Format.new('Audio clip','audio'),
      Format.new('Quiz','quiz'),
      Format.new('Study guide','study-guide'),
      Format.new('Worksheet','worksheet'),
      Format.new('Guide','guide'),
      Format.new('Programme','programme'),
      Format.new('Other','other')
    ]
  end
  
end

end
