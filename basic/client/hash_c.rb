# irb -r drb -r pp --noreadline --prompt dir
require 'drb'
require 'pp'
DRb.start_service
remote = DRbObject.new_with_uri('druby://localhost:7640')

remote['remote_foo'] = 'foo'
remote['remote_proc'] = Proc.new{ `pwd`}

remote['front_proc'][]
remote['remote_proc'][]
