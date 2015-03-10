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
      Level.new('KS1','z3g4d2p', 'Key Stage 1 is a phase of primary education for pupils aged 5 to 7 in England, or 6 to 8 in Northern Ireland.'), 
      Level.new('Early and 1st level', 'zgckjxs', 'Early level is a phase of pre-school and primary education in Scotland, generally for pupils aged 3 to 6. First level is a phase of primary education in Scotland, generally for pupils aged 6 to 9.'),
      Level.new('KS2','zbr9wmn', 'Key Stage 2 is a phase of primary education for pupils aged 7 to 11 in England and Wales, or 8 to 11 in Northern Ireland.'),
      Level.new('2nd Level', 'zr48q6f', 'Second Level is a phase of primary education in Scotland, generally for pupils aged 9 to 12.'),
      Level.new('3rd Level', 'zy4qn39', 'Third Level is a phase of education in Scotland, generally for pupils aged 11 to 15, in their first three years of secondary school.'),
      Level.new('4th Level', 'zvk2fg8', 'Fourth Level is a phase of education in Scotland, generally for pupils aged 11 to 15, in their first three years of secondary school.'),
      Level.new('CA3', 'zh6vr82', 'Mae Cyfnod Allweddol 3 yn cynrychioli’r tair blynedd cyntaf yn addysg ysgolion uwchradd Cymru, ar gyfer disgyblion 11-14 blwydd oed.'),
      Level.new('KS3','z4kw2hv', 'Key Stage 3 is the first three years of secondary school education in England, Wales and Northern Ireland, for pupils aged 11 to 14'),
      Level.new('GCSE','z98jmp3', 'GCSE is the qualification taken by 15 and 16 year olds to mark their graduation from the Key Stage 4 phase of secondary education in England, Northern Ireland and Wales.'),
      Level.new('National 4', 'zp3d7ty', 'National 4 is a qualification taken by students in Scotland, generally during their secondary senior phase of education.'),
      Level.new('National 5', 'z6gw2hv', 'National 5 is a qualification taken by students in Scotland, generally during their secondary senior phase of education.'),
      Level.new('Nàiseanta 4', 'z8hhvcw', '\'S e teisteanas do sgoilearan ann an Alba, a tha sa bhitheantas air a ghabhail aig ceann shuas na h-àrd-sgoile, a th\' ann an Ìre Nàiseanta 4'),
      Level.new('Nàiseanta 5', 'zdpp34j', '\'S e teisteanas do sgoilearan ann an Alba, a tha sa bhitheantas air a ghabhail aig ceann shuas na h-àrd-sgoile, a th\' ann an Ìre Nàiseanta 5.'),
      Level.new('TGAU', 'z8w76sg', 'Cymhwyster ar gyfer disgyblion 15 -16 blwydd oed yw TGAU. Mae’r cymhwyster yn dangos bod disgyblion wedi llwyddo i gwblhau Cyfnod Allweddol 4 yn ystod eu haddysg uwchradd yng Nghymru.'),
      Level.new('Higher', 'zkdqxnb', 'Highers are national school-leaving certificate exams and university entrance qualifications taken by 16 to 18 year olds in Scotland.')
    ]
  end
  
end


