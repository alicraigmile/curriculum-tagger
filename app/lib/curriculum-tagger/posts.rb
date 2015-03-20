require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'curriculum-data.sqlite3.db'
)

module CurriculumTagger

class Post < ActiveRecord::Base
end

end

