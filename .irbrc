#!/usr/bin/env ruby
require 'irb/completion'
require 'irb/ext/save-history'

$LOAD_PATH << '/home/miavision/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/awesome_print-1.8.0/lib'
require 'awesome_print'
AwesomePrint.irb!

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
