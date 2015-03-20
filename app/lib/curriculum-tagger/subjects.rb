# encoding: utf-8

module CurriculumTagger

class Subject
  attr_accessor :label, :id, :description

  def initialize (label, id = nil, description = nil)
    @label = label
    @id = id
    @description = description
  end

  def self.find_by (options={})
    self.all().find { |subject| subject.id == options[:id] }
  end

    
  def self.all ()
    [
      Subject.new('Architecture','zw2fb9q'),
      Subject.new('Art and Design','z8tnvcw'),
      Subject.new('Biology','z2svr82'),
      Subject.new('Business','zjnygk7'),
      Subject.new('Business management','zkmngk7'),
      Subject.new('Chemistry','zmf3cdm'),
      Subject.new('Computing','zft3d2p'),
      Subject.new('Cymraeg','zf48q6f'),
      Subject.new('Dance','zg9jtfr'),
      Subject.new('Design and manufacture','z3vrwmn'),
      Subject.new('Design and Technology','zykw2hv'),
      Subject.new('Drama','zk6pyrd'),
      Subject.new('Electronics','zvdqxnb'),
      Subject.new('Engineering','z763cdm'),
      Subject.new('Engineering science','zb3cjxs'),
      Subject.new('English','zt3rkqt'),
      Subject.new('English Literature','zhbc87h'),
      Subject.new('Expressive Arts','zkpv9j6'),
      Subject.new('Fashion and textile technology','zgb4q6f'),
      Subject.new('Food Technology','z3w76sg'),
      Subject.new('French','zc7xpv4'),
      Subject.new('Gaelic','zgj2tfr'),
      Subject.new('Gaelic (Learners)','zqnygk7'),
      Subject.new('Geography','z2f3cdm'),
      Subject.new('German','z426n39'),
      Subject.new('Graphic communication','zcrk2hv'),
      Subject.new('Graphics','zbj2tfr'),
      Subject.new('Health and food technology','z4c8mp3'),
      Subject.new('Health and wellbeing','zv6sr82'),
      Subject.new('History','z7svr82'),
      Subject.new('Hospitality','z94dxnb'),
      Subject.new('ICT','zf9d7ty'),
      Subject.new('Italian','z86pyrd'),
      Subject.new('Lifeskills Maths','z37qtfr'),
      Subject.new('Literacy and English','z8rdtfr'),
      Subject.new('Mandarin','zkxhfg8'),
      Subject.new('Maths','z6vg9j6'),
      Subject.new('Media Studies','zwpfb9q'),
      Subject.new('Modern Foreign Languages','zrqmhyc'),
      Subject.new('Modern Languages','z9frq6f'),
      Subject.new('Modern Studies','zs48q6f'),
      Subject.new('Music','z9xhfg8'),
      Subject.new('Music Technology','zvcjpv4'),
      Subject.new('People in society, economy and business','zjmh34j'),
      Subject.new('People, past events and societies','z76ngk7'),
      Subject.new('People, place and environment','zdgk2hv'),
      Subject.new('Physical Education','zdhs34j'),
      Subject.new('Physics','zxyb4wx'),
      Subject.new('Product Design','z4mtsbk'),
      Subject.new('PSHE and Citizenship','z7f3cdm'),
      Subject.new('Religious and moral education','zqxpb9q'),
      Subject.new('Religious Studies','zmyb4wx'),
      Subject.new('Religious, moral and philosophical studies','zdcwhyc'),
      Subject.new('Resistant Materials','zgqmhyc'),
      Subject.new('Science','z7nygk7'),
      Subject.new('Social Studies','z2tsr82'),
      Subject.new('Sociology','z33d7ty'),
      Subject.new('Spanish','z9mtsbk'),
      Subject.new('Systems and Control','zr7xpv4'),
      Subject.new('Technologies','zrg97ty'),
      Subject.new('Textiles','zc26n39'),
      Subject.new('Welsh (Learners)','zjpfb9q'),
      Subject.new('Welsh Literature','zy9d7ty')
    ]
  end
  
end

end
