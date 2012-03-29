require './drb_origin'
ODRb.start_service('druby://localhost:7640', {})
o = ODRbObject.new(nil, 'druby://localhost:7640')

loop do
  sleep 1
  o << 1
end