require File.dirname(__FILE__) + '/test_helper.rb'

class TestProxy < Test::Unit::TestCase
  def setup
  end
  
  def test_proxy_is_set
    proxy_me = MyStump.new
    
    assert_nothing_raised do
      proxy_me.proxy!(:tree)
      proxy_me.tree
    end
  end
  
  def test_proxy_value_is_returned
    proxy_me = MyStump.new
    
    assert_nothing_raised do
      proxy_me.proxy!(:tree, :return => "slacks")
      assert_equal "slacks", proxy_me.tree
    end
  end
  
  def test_proxy_is_added_to_tracker
    proxy_me = MyStump.new
    proxy_me.proxy!(:tree, "tea")
    
    assert_equal [[proxy_me, :tree]], Stump::Mocks.failures
  end
  
  def test_proxy_args_are_required
    proxied = MyStump.new
    proxied.proxy!(:trunk)
    
    assert_raise ArgumentError do
      proxied.trunk
    end
        
    assert_nothing_raised do
      assert_equal "HELLO", proxied.trunk("hello")
    end
  end

  def test_proxy_fail
    stumply = MyStump.new
    stumply.proxy!(:tree, "hi")
    
    assert_raise Test::Unit::AssertionFailedError do
      stumpdown!
    end
  end
  
  def test_proxy_pass
    stumply = MyStump.new
    stumply.proxy!(:tree, "hi")
    stumply.tree
    
    assert_nothing_raised do
      stumpdown!
    end
  end
  
  def teardown
    Stump::Mocks.clear!
  end
end
