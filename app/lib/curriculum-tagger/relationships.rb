 require 'active_record'

module CurriculumTagger

class Relationship < ActiveRecord::Base
  validates :subject, :predicate, :object, presence: true
end

end
