require 'test/unit'
require File.dirname(__FILE__) + '/../lib/stump'

class MyStump
  def tree
    "oak"
  end
  
  def trunk(name)
    return name.upcase
  end
end