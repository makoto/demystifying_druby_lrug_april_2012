require 'drb/drb'
require 'rinda/tuplespace'
ts = Rinda::TupleSpace.new
DRb.start_service('druby://:7641', ts)
DRb.thread.join
