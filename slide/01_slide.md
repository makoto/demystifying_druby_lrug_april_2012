!SLIDE bullets
# Demystifying dRuby #

!["http://pragprog.com/book/sidruby/the-druby-book"](sidruby.jpeg)

* @makoto_inoue (@newbamboo)

!SLIDE bullets incremental
# Who is Masatoshi Seki? #

* Author of dRuby, Rinda, and ERB
* Ruby core committer (Rubyist since 1998)
* C by Day, Ruby by Night
* Never used Rails (Can't install!!)
* PokeMon Master

!SLIDE bullets incremental

# Who is Masatoshi Seki? #
## PokeMon Master

![pokemon](pokemon.png)

!SLIDE bullets incremental

# Who is Masatoshi Seki? #
## PokeMon Master

![pokemonwcs](pokemonwcs2010.png)

!SLIDE bullets incremental

# Who is Masatoshi Seki? #
## Artist

![](magazine.png)

!SLIDE bullets incremental

# Who is Masatoshi Seki? #
## Resembles?

![](magazine.png)
![](imgres.jpeg)

!SLIDE bullets incremental

# What I want to talk about today

* dRuby == Creative & fun
* Mastering dRuby == Mastering Ruby
* (buy the book)

!SLIDE bullets incremental

# Topics

* Basic of dRuby
* Internal of dRuby
* Pass by value, Pass by reference
* Rinda
* Drip (if I have enough time)


!SLIDE bullets incremental

# Basic of dRuby

* Distributed Ruby
* Part of Ruby Standard libraries
* Proxy to remote object

!SLIDE
# Basic of dRuby
## Server

    @@@ ruby
    require 'drb/drb'                                           
    class Puts                                                  
      def initialize(stream=$stdout)
        @stream = stream
      end

      def puts(str)
        @stream.puts(str)
      end
    end

!SLIDE
# Basic of dRuby
## Server
    
    @@@ ruby
    uri = ARGV.shift
    DRb.start_service(uri, Puts.new)                            
    DRb.thread.join()

!SLIDE
# Basic of dRuby
## Client

    @@@ ruby
    require 'drb'
    there = DRbObject.new_with_uri('druby://:12345')
    there.puts("hello world")

!SLIDE bullets incremental
# Basic of dRuby
## What you just learnt

- DRb.start_service
- DRbObject.new\_with\_uri
- DRb.thread.join()

!SLIDE
# Internal of dRuby
## Where is the source?

    @@@ sh
    [.rvm]$ find . -name 'drb' -print
    ./src/ruby-1.9.3-p0/lib/drb
    ./src/ruby-1.9.3-p0/sample/drb
    ./src/ruby-1.9.3-p0/test/drb

!SLIDE

# Internal of dRuby
## Let's play with same samples  

    @@@ sh
    ruby  ~/.rvm/src/ruby-1.9.3-p0/sample/drb/drchats.rb
    ruby  ~/.rvm/src/ruby-1.9.3-p0/sample/drb/drchatc.rb

!SLIDE bullets 

# Internal of dRuby
## The first dRuby

* [160 lines of code](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/15406)   

!SLIDE bullets 

# Internal of dRuby
## Code Reading

* origin/drb\_origin.rb

!SLIDE bullets incremental

# Internal of dRuby
## What you learnt

* method_missing as proxy
* Marshal.dump everything
* If failed to dump, pass reference
* soc.write(str) to send 

!SLIDE bullets incremental
# Pass by Value, Pass by Reference
## Thing you can not Marshial.dump

* IO,File, Socket, etc
* Proc

!SLIDE bullets
# Pass by Value, Pass by Reference
## Example(Proc)

* Run proc\_s.rb and proc\_c.rb from irb

!SLIDE bullets
# Pass by Value, Pass by Reference
## Example(each)

* Run array\_s.rb and array\_c.rb

!SLIDE
# Example(each)

![](each.png)





