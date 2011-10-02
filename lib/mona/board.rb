class Mona::Board
  def initialize(host, board)
    @host = host
    @board = board
  end

  def dat_url
    "http://#{@host}/#{@board}/subject.txt"
  end
end
