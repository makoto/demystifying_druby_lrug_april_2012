# irb -r drb -r pp --noreadline --prompt dir
require 'drb'
require 'pp'
front = {}
DRb.start_service('druby://:7640', front)
server_proc = Proc.new{ `pwd`}
front['server_proc'] = server_proc
while true
  sleep 1
  puts "\n"
  pp front
  front.each do |k,v|
    p "#{k}:  #{v[]}"
  end
end