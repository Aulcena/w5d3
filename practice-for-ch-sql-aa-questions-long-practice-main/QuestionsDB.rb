require 'sqlite3'
require 'singleton'


class QuestionsDatabase < SQLite3::Database 
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User

  attr_accessor :id, :fname, :lname

  def self.find_by_name(fname, lname)
    name =  QuestionsDatabase.instance.execute("SELECT * FROM users WHERE users.fname = fname AND users.lname = lname")
    user_name = User.new(name.first)
    

  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE users.id = id")
    # data.map {|datum| Users.new(datum)}
    # data => [ {id: 3, fname: 'kin', lname: 'tse' } ]
    user = User.new(data.first)
  end

  def initialize(options) #hash
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']

  end
end 

class Question
    attr_accessor :id, :title, :body, :user_id
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE questions.id = id")
    # data.map {|datum| Users.new(datum)}
    # data => [ {id: 3, fname: 'kin', lname: 'tse' } ]
    question = Question.new(data.first)
  end

  def self.find_by_title(title)
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE questions.title = title")
    title = Question.new(data.first)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']

  end
end