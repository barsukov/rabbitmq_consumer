#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new
conn.start

ch = conn.create_channel
x  = ch.fanout("test")


ch.queue("bob",:auto_delete => true).bind(x).subscribe do |delivery_info, metadata, payload|
  puts "Received #{payload} => bob"
end

ch.queue("joe", :auto_delete => true).bind(x).subscribe do |delivery_info, metadata, payload|
  puts "Recieved #{payload} => joe"
end

x.publish("BOS 101, NYK 89").publish("ORL 85, ALT 88")


sleep 2.0
conn.close
