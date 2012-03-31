require 'drb'
class Foo
  include DRbUndumped

  def pwd
    r = `pwd`
    p r
    r
  end
end
