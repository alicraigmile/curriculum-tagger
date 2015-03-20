 
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'curriculum-data.sqlite3.db'
)

module CurriculumTagger

class Relationship < ActiveRecord::Base
  validates :subject, :predicate, :object, presence: true
end

end
