require 'drb'
arry = Array.new(10){ Proc.new{`pwd`}}

DRb.start_service('druby://localhost:7640', arry)
DRb.thread.join