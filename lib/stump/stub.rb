class Object
  # Create a stub method on an object.  Simply returns a value for a method call on
  # an object.
  #
  # ==== Examples
  #
  #    my_string = "a wooden rabbit"
  #    my_string.stub!(:retreat!, :return => "run away!  run away!")
  #
  #    # test/your_test.rb
  #    my_string.retreat!    # => "run away!  run away!"
  #
  def stub!(method_name, options = {}, &stubbed)
    behavior = (block_given? ? stubbed : proc { return options[:return] })

    class << self
      self
    end.instance_eval {
      define_method(method_name) { |*args, &block|
        behavior.call(*args, &block)
      }
    }
  end
end

module Kernel
  # Create a pure stub object.
  #
  # ==== Examples
  #
  #     stubbalicious = stub(:failure, "wat u say?")
  #     stubbalicious.failure     # => "wat u say?"
  #
  def stub(method, options = {}, &block)
    stub_object = Object.new
    stub_object.stub!(method, options, &block)

    stub_object
  end
end