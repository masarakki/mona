require 'time'

#
#Thread of 2ch.net
#
#
#
class Mona::Thread
  attr_reader :title, :id, :res_num, :board, :last_accessed_at, :dat_size

  #=== initialize method
  #
  #==== required options
  #_:board_:: instance of Board
  #_:id_:: thread id
  #==== optionals
  #_:title_:: title of thread
  #_:res_num_:: number of res
  #_:last_accessed_at_:: timestamp of last accessed time
  #_:dat_size_:: size of known dat file
  #
  def initialize(args = {})
    @board = args[:board]
    @title = args[:title]
    @id = args[:id]
    @res_num = args[:res_num]
    @last_accessed_at = Time.at(args[:last_accessed_at] || 0)
    @dat_size = args[:dat_size] || 0
  end

  def self.from_url(url)
    matched = url.match %r{http://(.+)/test/read.cgi/(.+)/(.+)/}
    raise "Invalid Url" unless matched
    board = Mona::Board.new(matched[1], matched[2])
    new(:board => board, :id => matched[3].to_i)
  end

  def parse_body(body)
    first = body.lines.first.strip.split(/<>/)
    @title = first[4] if first[4]
  end

  def reload
    headers = {'If-Modified-Since' => @last_accessed_at.rfc2822, 'Range' => @dat_size}
    res = Mona::Client.new.get(dat_url, :header => headers)

    case res.status
    when 200
      @dat_size += res.body.bytesize
      @last_accessed_at = Time.rfc2822(res.header["Last-Modified"].first)
      body = res.body.toutf8
      pase_body body
      body
    end
  end

  private
  #
  # === url for thread dat
  #
  def dat_url
    "http://#{board.host}/#{board.board}/dat/#{id}.dat"
  end
end
