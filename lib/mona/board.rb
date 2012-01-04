require 'kconv'

#
#Board of 2ch.net
#
class Mona::Board
  attr_reader :host, :board

  #
  #=== initialize method
  #
  #_host_:: subdomain
  #_board_:: board name
  #
  #==== example
  #if you want to access http://hayabusa2.2ch.net/news4vip/
  # Mona::Board.new('hayabusa2', 'news4vip')
  def initialize(host, board)
    @host = host
    @board = board
  end

  #
  #=== get threads
  #
  #array of Thread
  #
  def threads
    @threads ||= connect.toutf8.lines.map do |line|
      _, id, title, res_num = line.split(/^(\d+)\.dat<>(.+)\((\d+\))$/)
      Mona::Thread.new(board: self, title: title.strip, res_num: res_num.to_i, id: id.to_i)
    end
  end

  private

  #
  #=== url for subject.txt
  #
  def dat_url
    "http://#{@host}/#{@board}/subject.txt"
  end

  def connect
    res = Mona::Client.new.get(dat_url)
    if res.status == 200
      res.content.toutf8
    end
  end
end
