require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'curriculum-data.sqlite3.db'
)

class Relationship < ActiveRecord::Base

end


