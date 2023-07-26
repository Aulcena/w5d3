require 'sqlite3'
require 'singleton'
require 'byebug'


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

  def user_questions
    Question.find_by_user_id(self.id)
  end
end 

class Question
    attr_accessor :id, :title, :body, :user_id
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM questions WHERE questions.id = ?
    SQL
    # data.map {|datum| Users.new(datum)}
    # data => [ {id: 3, fname: 'kin', lname: 'tse' } ]
    question = Question.new(data.first)
  end

  def self.find_by_title(title)
    data = QuestionsDatabase.instance.execute(<<-SQL, title)
    SELECT * FROM questions WHERE questions.title = ?
    SQL
    title = Question.new(data.first)
  end
  def self.find_by_user_id(id)
    # data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE questions.user_id = id")
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM questions WHERE questions.user_id = ?
    SQL
    debugger
    user_id = Question.new(data.first)
  end

  def initialize(options)
    debugger
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']

  end
end

class QuestionsFollows
   
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows WHERE question_follows.id = id")
    q_follow = QuestionsFollows.new(data.first)

  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @questions_id = options['questions_id']
  end
end

class Replies

  attr_accessor :id, :body, :user_id, :replies_id, :questions_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE replies.id = id")
    reply = Replies.new(data.first)
  end

  def self.find_by_questions_id(q_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE replies.id = q_id")
    questions_id = Replies.new(data.first)
  end

  def self.find_by_user_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE replies.user_id = id")
    user_id = Replies.new(data.first)
  end

  def initialize(options)
    @id = options["id"]
    @body = options["body"]
    @user_id = options["user_id"]
    @replies_id = options["replies_id"]
    @questions_id = options["questions_id"]
  end
  
end

class QuestionLikes

  attr_accessor :id, :likes, :questions_id, :user_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes WHERE question_likes.id = id")
    likes = QuestionLikes.new(data.first)
  end

  def initialize(options)
    @id = options["id"]
    @questions_id = options["questions_id"]
    @user_id = options["user_id"]
  end

end
