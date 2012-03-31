# irb -r drb -r pp --noreadline --prompt dir
require 'drb'
require 'pp'
front = {}
DRb.start_service('druby://localhost:7640', front)

front['front_foo'] = 'foo'
front['front_proc'] = Proc.new{ `pwd`}

p front
pp front

front['front_proc'][]
front['remote_proc'][]