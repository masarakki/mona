require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mona::Client do
  before do
    Mona.stub(:version) { '0.7.2' }
  end
  let(:time) { Time.now - 3600 }
  context :with_args do
    subject { Mona::Client.new(last_accessed_at: time, agent_name: 'UnkoBrowser') }
    its(:last_accessed_at) { should eq time }
    its(:agent_name) { should eq 'UnkoBrowser/0.7.2 (ruby-mona)' }
  end
  context :without_args do
    subject { Mona::Client.new }
    its(:last_accessed_at) { should eq 0 }
    its(:agent_name) { should eq 'Monazilla/0.7.2 (ruby-mona)' }
  end
end
