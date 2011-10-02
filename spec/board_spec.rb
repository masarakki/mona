require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mona::Board do
  subject { Mona::Board.new('localhost', 'board_001') }
  its(:dat_url) { should eq("http://localhost/board_001/subject.txt") }
end
