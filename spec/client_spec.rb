require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mona::Client do
  before do
    Mona.stub(:version) { '0.7.2' }
  end
  context :with_args do
    subject { Mona::Client.new(agent_name: 'UnkoBrowser') }
    its(:agent_name) { should eq 'UnkoBrowser/0.7.2 (ruby-mona)' }
  end
  context :without_args do
    subject { Mona::Client.new }
    its(:agent_name) { should eq 'Monazilla/0.7.2 (ruby-mona)' }
  end
end
