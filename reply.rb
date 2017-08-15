require_relative "questions_db"

class Reply
  attr_accessor :title, :body
  attr_reader :id, :parent_reply, :question_id

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
  end
end
