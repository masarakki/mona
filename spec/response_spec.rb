# -*- coding: utf-8 -*-
require 'spec_helper'
require 'time'

describe Mona::Response do
  subject { @response }
  before do
    @response = Mona::Response
  end

  describe :ClassMethod do
    describe :parse_name do
      context :with_trip do
        subject { Mona::Response.parse_name('天使 </b>◆uL5esZLBSE <b>') }
        its(:first) { should == '天使' }
        its(:last) { should == 'uL5esZLBSE' }
      end
      context :without_trip do
        subject { Mona::Response.parse_name('仕様書名無しさん') }
        its(:first) { should == '仕様書名無しさん' }
        its(:last) { should be_nil }
      end
    end
    describe :parse_line do
      before do
        @response = Mona::Response.parse_line('天使 </b>◆uL5esZLBSE <b><>sage<>2011/07/01(金) 22:13:46.37 <> Rubyバカにしてる子ってさ <br> 変数に＄ついてる言語触ってるって事だよね <br>  <br> いちいちSHIFT＋４キーおして ＄ 打ちまくってる感触はどう？ <>')
      end

      its(:name) { should == '天使' }
      its(:trip) { should == 'uL5esZLBSE' }
      its("written_at.to_i") { should == Time.local(2011, 7, 1, 22, 13, 46).to_i }
      its("written_at.zone") { should == "JST" }
      its(:body) { should == "Rubyバカにしてる子ってさ
変数に＄ついてる言語触ってるって事だよね

いちいちSHIFT＋４キーおして ＄ 打ちまくってる感触はどう？" }
    end
  end
end
