module Stump
  module Baconize
    module ContextExtensions
      def self.included(base)
        base.class_eval do
          alias_method :it_without_mock_verification, :it
          alias_method :it, :it_with_mock_verification
        end
      end

      def verify_mocks
        if !Stump::Mocks.failures.nil? && !Stump::Mocks.failures.empty?
          fails = Stump::Mocks.failures.map {|object, method| "#{object.inspect} expected #{method}"}.join(", ")
          should.flunk "Unmet expectations: #{fails}"
        end
      end

      def it_with_mock_verification(description, &block)
        @after << proc { verify_mocks }
        it_without_mock_verification(description, &block)
      ensure
        Stump::Mocks.clear!
      end
    end
  end
end

begin
  Bacon::Context.class_eval { include Stump::Baconize::ContextExtensions }
rescue LoadError
  puts 'Bacon is not available.'
end