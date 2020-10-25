# frozen_string_literal: true

module Operation
  class Errors
    delegate :empty?,
             to: :@errors

    def initialize(errors:)
      @errors = errors
    end

    def fetch(type)
      return unless @errors.key?(type)

      args = @errors.fetch(type)
      yield(type.new(*args))
    end

    def each
      @errors.each do |_klass, args|
        yield(type.new(*args))
      end
    end
  end

  class Result < SimpleDelegator
    attr_reader :errors

    def initialize(obj, errors = {})
      super(obj)
      @errors = Errors.new(errors: errors)
    end

    def success?
      @errors.empty?
    end

    def success
      yield if success?
    end

    def failure(type = nil, &block)
      if type
        @errors.fetch(type, &block)
      elsif block_given?
        @errors.each(&block)
      else
        raise ArgumentError, 'Either error type or block is required'
      end
    end
  end
end
