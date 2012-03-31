require 'drb'
DRb.start_service
arry = DRbObject.new_with_uri('druby://localhost:7640')

 arry.each{|a| p `pwd`; p a[]}