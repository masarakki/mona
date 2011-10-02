class Mona::Thread
  attr_reader :title, :id, :res
  def initialize(args = {})
    @title = args[:title]
    @id = args[:id]
    @res = args[:res]
  end
end
