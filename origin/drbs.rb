require './drb_origin.rb'
a = []
ODRb.start_service('druby://localhost:7640', a)
loop do
  sleep 1
  p a
end
ODRb.thread.join

# Usage
# require './drb_origin'
# ODRb.start_service('druby://localhost:7640', {})
# o = ODRbObject.new(nil, 'druby://localhost:7640')
