require 'drb/drb'
require 'rinda/rinda'

# def do_it(v)
#   puts "do_it(#{v})"
#   v + v
# end
# 
DRb.start_service
@ts = DRbObject.new_with_uri('druby://:7641')
# 
# while true
#   r = ts.take(['sum', nil, nil])
#   v = do_it(r[2])
#   ts.write(['ans', r[1], r[2], v])
# end
