require 'sqlite3'
require 'singleton'


class QuestionsDatabase < SQLite3::Database 
  include 'singleton'
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Users

  def self.find_by_name(fanme, lname)

  end

  def initialize(options)
    id = options['id']
    fname = options['fname']
    lname = options['lname']

  end
end 