require 'drb'
arry = Array.new(10){ Proc.new{ p `pwd`}}

DRb.start_service('druby://:7640', arry)
DRb.thread.join