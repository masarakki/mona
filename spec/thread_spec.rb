require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mona::Thread do
  before do
    @accessed_at = Time.now - 6400
    @board = Mona::Board.new('localhost', 'board_001')
  end

  subject { Mona::Thread.new(title: 'title', board: @board, id: 101010, res_num: 34, last_accessed_at: @accessed_at) }
  its(:title) { should eq 'title' }
  its(:board) { should eq @board }
  its(:id) { should eq 101010 }
  its(:res_num) { should eq 34 }
  its(:last_accessed_at) { should eq @accessed_at }
end
