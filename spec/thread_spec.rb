# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def test_dat
  File.read(File.expand_path(File.dirname(__FILE__) + '/test_data/dat.txt'))
end


describe Mona::Thread do

  let(:accessed_at) { Time.now - 6400 }
  let(:board) { Mona::Board.new('localhost', 'board_001') }

  subject { Mona::Thread.new(title: 'title', board: board, id: 101010, res_num: 34, dat_size: 100, last_accessed_at: accessed_at) }
  its(:title) { should eq 'title' }
  its(:board) { should eq board }
  its(:id) { should eq 101010 }
  its(:res_num) { should eq 34 }
  its(:last_accessed_at) { should eq accessed_at }
  its(:dat_url) { should eq "http://localhost/board_001/dat/101010.dat" }
  its(:dat_size) { should eq 100 }
  describe :reload do
    it { 'hoge' }
  end

  describe :parse_body do
    subject { Mona::Thread.new }

    it do
      lambda {
        subject.parse_body test_dat.toutf8
      }.should change(subject, :title).from(nil).to('ウツ病のプログラマーを雇うスレ')
    end
  end
end

describe Mona::Thread, 'real' do
  subject { Mona::Thread.new(board: Mona::Board.new('hibari.2ch.net', 'prog'), id: 1210150210) }
  it "reload should change last_accessed_at" do
    pending
    lambda {
      subject.reload
    }.should change(subject, :last_accessed_at)
    subject.reload.should be_nil
  end
end
