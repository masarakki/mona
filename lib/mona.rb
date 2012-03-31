#Mona - 2ch library.
#Copyright (C) 2011- masarakki <masaki@hisme.net>
#
#== How to access 2ch.net
#
#first, create instance of Board.
#if you want to access to hayabusa2.2ch.net/news4vip,
# board = Mona::Board.new('hayabusa2', 'news4vip')
#then you can get list of Thread by
# threads = board.threads
#or if you know thread info, you can create Thread instance
# thread = Mona::Thread.new(:board => Mona::Board.new('hayabusa2', 'news4vip'), :id => 101010101)
#
module Mona
  autoload :Client, 'mona/client'
  autoload :Board, 'mona/board'
  autoload :Thread, 'mona/thread'
  autoload :Response, 'mona/response'

  VERSION_MAJOR = 0
  VERSION_MINOR = 1
  VERSION_PATCH = 0

  def self.version
    [VERSION_MAJOR, VERSION_MINOR, VERSION_PATCH].join('.')
  end
end
