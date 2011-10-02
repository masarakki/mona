class Mona::Thread
  attr_reader :title, :id, :res_num, :board, :last_accessed_at
  def initialize(args = {})
    @board = args[:board]
    @title = args[:title]
    @id = args[:id]
    @res_num = args[:res_num]
    @last_accessed_at = args[:last_accessed_at] || 0
  end
end
