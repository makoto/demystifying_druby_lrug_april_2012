require 'drb'
@remote = DRbObject.new_with_uri('druby://localhost:12345')

puts "@remote = DRbObject.new_with_uri('druby://localhost:12345')"