require 'drb'
DRb.start_service
arry = DRbObject.new_with_uri('druby://:7640')

arry.map{|a| p `pwd`; a[]}