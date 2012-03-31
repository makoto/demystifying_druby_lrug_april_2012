require 'drb'

DRb.start_service('druby://localhost:7640', a)
loop do
  sleep 1
  p a
end