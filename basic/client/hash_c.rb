# irb -r drb -r pp --noreadline --prompt dir
require 'drb'
require 'pp'
DRb.start_service
remote = DRbObject.new_with_uri('druby://:7640')

client_proc = Proc.new{`pwd`}
remote['client_proc'] = client_proc

DRb.thread.join