require 'time'

class Mona::Thread
  attr_reader :title, :id, :res_num, :board, :last_accessed_at, :dat_size
  def initialize(args = {})
    @board = args[:board]
    @title = args[:title]
    @id = args[:id]
    @res_num = args[:res_num]
    @last_accessed_at = Time.at(args[:last_accessed_at] || 0)
    @dat_size = args[:dat_size] || 0
  end

  def dat_url
    "http://#{board.host}/#{board.board}/dat/#{id}.dat"
  end

  def reload
    headers = {'If-Modified-Since' => @last_accessed_at.rfc2822, 'Range' => @dat_size}
    res = Mona::Client.new.get(dat_url, :header => headers)

    case res.status
    when 200
      @dat_size += res.body.bytesize
      @last_accessed_at = Time.rfc2822(res.header["Last-Modified"].first)

      res.body.toutf8
    end
  end
end
