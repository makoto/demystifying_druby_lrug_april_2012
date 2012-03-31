require 'drb'
class Foo
  include DRbUndumped

  def pwd
    r = `pwd`
    r
  end
end
