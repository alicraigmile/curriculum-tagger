class Level
  attr_accessor :label, :id

  def initialize (label, id = nil)
    @label = label
    @id = id
  end
  
  def self.all ()
    [
        Level.new('KS1','z3g4d2p'), 
        Level.new('KS2','zbr9wmn'),
        Level.new('KS3','z4kw2hv'),
        Level.new('GCSE','z98jmp3'),
        Level.new('Higher', 'zkdqxnb')
    ]
  end
  
end


