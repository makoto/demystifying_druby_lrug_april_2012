require 'drb'
require '../client/foo'
arry = Array.new(10){ Foo.new}

DRb.start_service('druby://localhost:7640', arry)
DRb.thread.join