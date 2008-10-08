require File.dirname(__FILE__) + '/test_helper.rb'

class TestStub < Test::Unit::TestCase
  def setup
  end
  
  def test_stub_is_set
    stub_me = MyStump.new
    
    assert_nothing_raised do
      stub_me.stub!(:pants)
      stub_me.pants
    end
  end
  
  def test_stub_value_is_returned
    stub_me = MyStump.new
    
    assert_nothing_raised do
      stub_me.stub!(:pants, :return => "slacks")
      assert_equal "slacks", stub_me.pants
    end
  end
  
  def test_stub_object_is_created
    assert_nothing_raised do
      stubbed = stub(:hello)
      stubbed.hello
    end
  end
  
  def test_stub_object_can_add_stub_methods
    assert_nothing_raised do
      stubbed = stub(:hello)

      stubbed.stub!(:more, :return => "meep")
      assert_equal "meep", stubbed.more
    end
  end
  
  def test_stub_is_created_with_block
    assert_nothing_raised do
      my_stub = MyStump.new
      my_stub.stub!(:lose) do
        "FAIL"
      end
      
      assert_equal "FAIL", my_stub.lose
    end
  end
  
  def test_stub_is_created_without_argument
    assert_nothing_raised do
      stubble = MyStump.new
      stubble.stub!(:blank)
      stubble.blank
    end
  end
  
  def test_stub_with_block_takes_args
    assert_nothing_raised do
      stubble = MyStump.new
      stubble.stub!(:spaz) do |arg1, arg2|
        arg1 + arg2
      end
      
      assert_equal 3, stubble.spaz(1,2)
    end
  end
  
  def test_stub_with_block_requires_args
    assert_raise ArgumentError do
      stubble = MyStump.new
      stubble.stub!(:spaz) do |arg1, arg2|
        arg1 + arg2
      end
      
      assert_equal 3, stubble.spaz
    end
  end
  
  def teardown
    Stump::Mocks.clear!
  end
end
