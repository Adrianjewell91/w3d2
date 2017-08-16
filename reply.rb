require_relative "questions_db"
require_relative "question"
require 'byebug'
class Reply
  attr_accessor :title, :body
  attr_reader :id, :parent_reply, :question_id, :author_id

  def self.find_by_author_id(author_id)
    replies = QuestionsDB.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL
    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @parent_reply = options["parent_reply"]
    @question_id = options["question_id"]
    @author_id = options["author_id"]
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    # byebug
    reply = QuestionsDB.instance.execute(<<-SQL, @parent_reply)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil unless reply.length > 0 
    [Reply.new(reply.first)]
  end
end
