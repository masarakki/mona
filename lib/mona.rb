module Mona
  autoload :Client, 'mona/client'
  autoload :Board, 'mona/board'
  autoload :Thread, 'mona/thread'

  VERSION_MAJOR = 0
  VERSION_MINOR = 1
  VERSION_PATCH = 0

  def self.version
    [VERSION_MAJOR, VERSION_MINOR, VERSION_PATCH].join('.')
  end
end
