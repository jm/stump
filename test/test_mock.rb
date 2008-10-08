require File.dirname(__FILE__) + '/test_helper.rb'

class TestMock < Test::Unit::TestCase
  def setup
  end
  
  def test_mock_is_set
    mock_me = MyStump.new
    
    assert_nothing_raised do
      mock_me.mock!(:pants)
      mock_me.pants
    end
  end
  
  def test_mock_value_is_returned
    mock_me = MyStump.new
    
    assert_nothing_raised do
      mock_me.mock!(:pants, :return => "slacks")
      assert_equal "slacks", mock_me.pants
    end
  end
  
  def test_mock_is_added_to_tracker
    mock_me = MyStump.new
    mock_me.mock!(:biscuits, "tea")
    
    assert_equal [[mock_me, :biscuits]], Stump::Mocks.failures
  end
  
  def test_mock_object_is_created
    assert_nothing_raised do
      mocked = mock(:hello)
      mocked.hello
    end
  end
  
  def test_mock_object_can_add_mock_methods
    assert_nothing_raised do
      mocked = mock(:hello)

      mocked.mock!(:more, :return => "meep")
      assert_equal "meep", mocked.more
    end
  end
  
  def test_mock_is_created_with_block
    assert_nothing_raised do
      my_mock = MyStump.new
      my_mock.mock!(:lose) do
        "FAIL"
      end
      
      assert_equal "FAIL", my_mock.lose
    end
  end
  
  def test_mock_is_created_without_argument
    assert_nothing_raised do
      mockery = MyStump.new
      mockery.mock!(:blank)
      mockery.blank
    end
  end
  
  def test_mock_with_block_takes_args
    assert_nothing_raised do
      mockery = MyStump.new
      mockery.mock!(:spaz) do |arg1, arg2|
        arg1 + arg2
      end
      
      assert_equal 3, mockery.spaz(1,2)
    end
  end
  
  def test_mock_with_block_requires_args
    assert_raise ArgumentError do
      mockery = MyStump.new
      mockery.mock!(:spaz) do |arg1, arg2|
        arg1 + arg2
      end
      
      assert_equal 3, mockery.spaz
    end
  end
  
  def test_mock_fail
    stumply = MyStump.new
    stumply.mock!(:hello, "hi")
    
    assert_raise Test::Unit::AssertionFailedError do
      stumpdown!
    end
  end
  
  def test_mock_pass
    stumply = MyStump.new
    stumply.mock!(:hello, "hi")
    stumply.hello
    
    assert_nothing_raised do
      stumpdown!
    end
  end
  
  def teardown
    Stump::Mocks.clear!
  end
end
