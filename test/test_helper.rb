# http://sneaq.net/textmate-wtf
$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'throat_punch'

require File.dirname(__FILE__) + '/../lib/snip_snap'

class Test::Unit::TestCase

  def read_fixture(filename)
    File.read(File.dirname(__FILE__) + '/fixtures/' + filename)
  end

end