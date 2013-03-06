# -*- coding: utf-8 -*-
require 'time'

class Mona::Response
  attr_accessor :name, :trip, :written_at, :body
  def initialize(options)
    options.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  class << self
    def parse_line(line)
      name, _, time_str, body, _ = line.to_s.split(/<>/)
      name, trip = parse_name(name)
      time = Time.parse(time_str + " +09:00")
      body = body.strip.split(' <br> ').join("\n")
      Mona::Response.new(name: name, trip: trip, written_at: time, body: body)
    end

    def parse_name(name)
      name, trip = name.split(/ <\/b>/)
      trip = trip.match(/\w+/)[0] if trip
      [name, trip]
    end
  end
end
