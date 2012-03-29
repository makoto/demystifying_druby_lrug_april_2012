=begin
 Tiny distributed Ruby --- dRuby
 ODRb --- dRuby module.
 ODRbProtocol --- Mixin class.
 ODRbObject --- dRuby remote object.
 ODRbConn --- 
 ODRbServer --- dRuby message handler.
=end

require 'socket'

module ODRb
  def start_service(uri, front=nil)
    @uri = uri.to_s
    @front = front
    @server = ODRbServer.new(@uri)
    @thread = @server.run
  end
  module_function :start_service

  attr :uri
  module_function :uri

  attr :thread
  module_function :thread

  attr :front
  module_function :front
end

module ODRbProtocol
  def parse_uri(uri)
    if uri =~ /^druby:\/\/(.+?):(\d+)/
      host = $1
      port = $2.to_i
      [host, port]
    else
      raise RuntimeError, 'can\'t parse uri'
    end
  end

  def dump(obj, soc)
    begin
      str = Marshal::dump(obj)
    rescue
      ro = ODRbObject.new(obj)
      str = Marshal::dump(ro)
    end
    soc.write(str) if soc
    return str
  end

  def send_request(soc, ref,msg_id, *arg)
    p "send_request: #{soc}, #{ref},#{msg_id}, #{arg.inspect}"
    dump(ref, soc)
    dump(msg_id.id2name, soc)
    dump(arg.length, soc)
    arg.each do |e|
      dump(e, soc)
    end
  end
  
  def recv_reply(soc)
    p "recv_reply: #{soc}"
    succ = Marshal::load(soc)
    result = Marshal::load(soc)
    [succ, result]
  end

  def recv_request(soc)
    p "recv_request: #{soc}"
    ro = Marshal::load(soc)
    msg = Marshal::load(soc)
    argc = Marshal::load(soc)
    argv = []
    argc.times do
      argv.push Marshal::load(soc)
    end
    r = [ro, msg, argv]
    p r
    r
  end

  def send_reply(soc, succ, result)
    dump(succ, soc)
    dump(result, soc)
  end
end

class ODRbObject
  def initialize(obj, uri=nil)
    @uri = uri || ODRb.uri
    @ref = obj.id if obj
  end

  def method_missing(msg_id, *a)
    succ, result = ODRbConn.new(@uri).send_message(self, msg_id, *a)
    raise result if ! succ
    result
  end

  attr :ref
end

class ODRbConn
  include ODRbProtocol

  def initialize(remote_uri)
    @host, @port = parse_uri(remote_uri)
  end

  def send_message(ref, msg_id, *arg)
    begin
      soc = TCPSocket.open(@host, @port)
      send_request(soc, ref, msg_id, *arg)
      recv_reply(soc)
    ensure
      soc.close if soc
#      ObjectSpace.garbage_collect
    end
  end
end

class ODRbServer
  include ODRbProtocol

  def initialize(uri)
    @host, @port = parse_uri(uri)
    @soc = TCPServer.open(@port)
    @uri = uri.dup
  end

  def run
    Thread.start do
      while true
	proc
      end
    end
  end

  def proc
    ns = @soc.accept
    Thread.start do
      begin
	s = ns
	begin 
	  ro, msg, argv = recv_request(s)
	  if ro and ro.ref
	    obj = ObjectSpace._id2ref(ro.ref)
	  else
	    obj = ODRb.front
	  end
	  result = obj.__send__(msg.intern, *argv)
	  succ = true
	rescue
	  result = $!
	  succ = false
	end
	send_reply(s, succ, result)
      ensure
	close s if s
#	ObjectSpace.garbage_collect
      end
    end
  end
end
