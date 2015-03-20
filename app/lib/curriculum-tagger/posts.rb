require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  File.join(File.dirname(__FILE__), '../../curriculum-data.sqlite3.db')
)

module CurriculumTagger

class Post < ActiveRecord::Base
end

end

