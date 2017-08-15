require_relative 'questions_db'
require_relative 'user'

class Question
  attr_accessor :title, :body
  attr_reader :id, :author_id

  def self.find_by_id(id)
    question = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    return nil unless question.length > 0
    Question.new(question.first)
  end

  def self.find_by_title(title)
    question = QuestionsDB.instance.execute(<<-SQL, title)
    SELECT
    *
    FROM
    questions
    WHERE
    title = ?
    SQL
    return nil unless question.length > 0
    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDB.instance.execute(<<-SQL, author_id)
    SELECT
    *
    FROM
    questions
    WHERE
    author_id = ?
    SQL
    return nil unless questions.length > 0
    questions.map {|question| Question.new(question) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    author = QuestionsDB.instance.execute(<<-SQL, @author_id)
      SELECT
        users.*
      FROM
        users
        JOIN questions
        ON questions.author_id = users.id
      WHERE
        author_id = ?
    SQL
    author
  end

end
