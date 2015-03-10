class Level
  attr_accessor :label, :id, :description

  def initialize (label, id = nil, description = nil)
    @label = label
    @id = id
    @description = description
  end

  def self.find_by (options={})
    self.all().find { |level| level.id == options[:id] }
  end

    
  def self.all ()
    [
      Level.new('KS1','z3g4d2p', ''), 
      Level.new('Early and 1st level', 'zgckjxs'),
      Level.new('KS2','zbr9wmn', 'Key Stage 2 is a phase of primary education for pupils aged 7 to 11 in England and Wales, or 8 to 11 in Northern Ireland.'),
      Level.new('2nd Level', 'zr48q6f'),
      Level.new('3rd Level', 'zy4qn39'),
      Level.new('4th Level', 'zvk2fg8', 'Fourth Level is a phase of education in Scotland, generally for pupils aged 11 to 15, in their first three years of secondary school.'),
      Level.new('CA3', 'zh6vr82'),
      Level.new('KS3','z4kw2hv'),
      Level.new('GCSE','z98jmp3'),
      Level.new('National 4', 'zp3d7ty'),
      Level.new('National 5', 'z6gw2hv'),
      Level.new('Nàiseanta 4', 'z8hhvcw'),
      Level.new('Nàiseanta 5', 'zdpp34j'),
      Level.new('TGAU', 'z8w76sg'),
      Level.new('Higher', 'zkdqxnb')
    ]
  end
  
end


