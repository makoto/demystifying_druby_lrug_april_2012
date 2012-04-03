require 'drip'
require 'my_drip'
require 'pp'

class NilClass
  def method_missing(method, *args)
    nil
  end
end

MyDrip.invoke

# Example
# MyDrip.write(20, 'seki.age', 'male')
# MyDrip.write(14, 'sora_h', 'male')
# MyDrip.write(29, 'kate', 'female')
# MyDrip.write(30, 'will', 'male')

puts 'Reading 4 items(min 1), time out 2 sec'
puts 'MyDrip.read(k, 4, 1, 2)[0]'
k = 0
while k 
  sleep 2
  r = MyDrip.read(k, 4, 1, 2)
  pp r; puts "\n"
  k = r[-1][0]
end
