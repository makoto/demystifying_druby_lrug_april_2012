require 'drip'
require 'my_drip'
require 'pp'
MyDrip.invoke

puts "Reading male tags from new to old"
puts "MyDrip.older(k, 'male')"

k,v, *tags = MyDrip.head(1, 'male')[0]
p [k, v, *tags]

while k 
  sleep 0.5
  k,v, *tags = MyDrip.older(k, 'male')
  p [k, v, *tags]
end