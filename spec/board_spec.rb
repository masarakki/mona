# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def test_subject
  File.read(File.expand_path(File.dirname(__FILE__) + '/test_data/subject.txt'))
end

describe Mona::Board do
  before do
    Mona::Board.any_instance.stub(:connect) { test_subject }
  end

  subject { Mona::Board.new('localhost', 'board_001') }
  its(:dat_url) { should eq("http://localhost/board_001/subject.txt") }
  describe :threads do
    subject { Mona::Board.new('localhost', 'board_001').threads }
    its(:count) { should eq 2 }
    its('first.title') { should eq'【東京】岩手の食材をテーマにした居酒屋が復興目指して急遽オープン' }
    its('first.id') { should eq 1317477718 }
    its('first.res_num') { should eq 49 }
    its('first.board') { should eq subject }
  end
end
