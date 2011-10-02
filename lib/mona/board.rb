require 'net/http'
require 'kconv'

class Mona::Board
  def initialize(host, board)
    @host = host
    @board = board
  end

  def dat_url
    "http://#{@host}/#{@board}/subject.txt"
  end

  def connect
    Net::HTTP.start(@host, 80) do |http|
      http.get("/#{@board}/subject.txt").body
    end
  end

  def threads
    @threads ||= connect.toutf8.lines.map do |line|
      _, id, title, res = line.split(/^(\d+)\.dat<>(.+)\((\d+\))$/)
      Mona::Thread.new(title: title.strip, res: res.to_i, id: id.to_i)
    end
  end
end
