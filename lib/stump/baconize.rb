module Facon
  # == Bacon integration
  #
  # To use Facon with Bacon, simply <code>require 'facon'</code>. Facon injects
  # itself into Bacon if it can find it, so all you have to do is to make sure
  # you have Bacon and Facon available on the load path.
  #
  # == Example
  #
  # In <code>spec_helper.rb</code>:
  #   require 'rubygems'
  #   require 'bacon'
  #   require 'facon'
  #
  # Simply <code>require</code> your <code>spec_helper.rb</code> in your specs and you are now
  # able to create mocks and expectations:
  #
  #   require '/path/to/spec_helper'
  #
  #   describe 'My examples' do
  #     it "should allow mocks and expectations" do
  #       @mock = mock('test mock')
  #       @mock.should.receive(:message).and_return(:foo)
  #
  #       do_something_with(@mock)
  #     end
  #   end
  module Baconize

    # Mixin intended for Bacon::Context so that it runs spec_verify on all mocks
    # after each example.
    module ContextExtensions
      def self.included(base)
        base.class_eval do
          alias_method :it_without_mock_verification, :it
          alias_method :it, :it_with_mock_verification
        end
      end

      def it_with_mock_verification(description, &block)
        if !Stump::Mocks.failures.nil? && !Stump::Mocks.failures.empty?
          fails = Stump::Mocks.failures.map {|object, method| "#{object.inspect} expected #{method}"}.join(", ")
          flunk "Unmet expectations: #{fails}"
        end

        it_without_mock_verification(description, &block)
      ensure
        Stump::Mocks.clear!
      end
    end
  end
end


begin
  Bacon::Context.class_eval { include Facon::Baconize::ContextExtensions }
rescue LoadError
  puts 'Bacon is not available.'
end
