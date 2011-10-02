class Mona::Thread
  attr_reader :title, :id, :res_num, :board, :last_accessed_at
  def initialize(args = {})
    @board = args[:board]
    @title = args[:title]
    @id = args[:id]
    @res_num = args[:res_num]
    @last_accessed_at = args[:last_accessed_at] || 0
  end

  def dat_url
    "http://#{board.host}/#{board.board}/dat/#{id}.dat"
  end

  def reload
    res = Mona::Client.new.get(dat_url)
    if res.status == 200
      res.body.toutf8
    end
  end
end
