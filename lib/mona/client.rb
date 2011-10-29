require 'httpclient'
class Mona::Client < ::HTTPClient
  attr_reader :last_accessed_at
  def initialize(args = {})
    agent_name = args.delete(:agent_name) || 'Monazilla'
    agent_name += "/#{Mona.version} (ruby-mona)"
    super(agent_name: agent_name)
    self.transparent_gzip_decompression = true
  end
end
