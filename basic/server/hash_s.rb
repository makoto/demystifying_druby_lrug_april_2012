# irb -r drb -r pp --noreadline --prompt dir
require 'drb'
require 'pp'
front = {}
DRb.start_service('druby://localhost:7640', front)

front['server_proc'] = Proc.new{ `pwd`}

p front
pp front

front['server_proc'][]
front['client_proc'][]