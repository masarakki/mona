require 'kconv'

class Mona::Board
  attr_reader :host, :board

  def initialize(host, board)
    @host = host
    @board = board
  end

  def dat_url
    "http://#{@host}/#{@board}/subject.txt"
  end

  def connect
    res = Mona::Client.new.get(dat_url)
    if res.status == 200
      res.content.toutf8
    end
  end

  def threads
    @threads ||= connect.toutf8.lines.map do |line|
      _, id, title, res_num = line.split(/^(\d+)\.dat<>(.+)\((\d+\))$/)
      Mona::Thread.new(board: self, title: title.strip, res_num: res_num.to_i, id: id.to_i)
    end
  end
end
