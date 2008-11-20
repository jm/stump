require File.dirname(__FILE__) + '/test_helper.rb'

class ProxyPants
  def method_missing(method_name, arguments)
    if method_name.to_s =~ /fun_/
      return "whoo #{method_name} party!!"
    else
      super
    end
  end
end

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
    proxy_me.proxy!(:tree, :return =>  "tea")
    
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

  def test_proxy_optional_args_are_not_required
    proxied = MyStump.new
    proxied.proxy!(:branch)
    
    assert_raise ArgumentError do
      proxied.branch
    end
    
    assert_nothing_raised do
      assert_equal 3, proxied.branch(3)
      assert_equal 6, proxied.branch(3, 2)
    end
  end
  
  def test_proxy_fail
    stumply = MyStump.new
    stumply.proxy!(:tree, :return => "hi")
    
    assert_raise Test::Unit::AssertionFailedError do
      stumpdown!
    end
  end
  
  def test_proxy_pass
    stumply = MyStump.new
    stumply.proxy!(:tree, :return => "hi")
    stumply.tree
    
    assert_nothing_raised do
      stumpdown!
    end
  end
  
  def test_proxy_method_missing
    obj = ProxyPants.new
    
    obj.proxy!(:fun_pants)
    assert_equal "whoo fun_pants party!!", obj.fun_pants
  end
  
  def test_proxy_method_missing_with_return
    obj = ProxyPants.new
    
    obj.proxy!(:fun_party, :return => "party time in the city!!")
    assert_equal "party time in the city!!", obj.fun_party
  end
  
  def test_proxy_method_missing_fails_with_no_method_match
    obj = ProxyPants.new
    
    assert_raises NoMethodError do
      obj.proxy!(:fail_pants)
      obj.fail_pants
    end
  end
  
  def test_proxy_method_missing_fail
    stumply = ProxyPants.new
    stumply.proxy!(:fun_tree, :return => "hello")
    
    assert_raise Test::Unit::AssertionFailedError do
      stumpdown!
    end
  end
  
  def teardown
    Stump::Mocks.clear!
  end
end
