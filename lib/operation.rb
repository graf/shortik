# frozen_string_literal: true

module Operation
  extend ActiveSupport::Concern

  def call
    raise NotImplementedError
  end

  module ClassMethods
    def call(**args, &block)
      new(**args).call(&block)
    end
  end

  private

  def step(method)
    return @_operation_result if @_operation_failed

    result = send(method)
    @_operation_result = construct_result(result)
    @_operation_failed = !@_operation_result.success?
    @_operation_result
  end

  def construct_result(value)
    return value if value.respond_to?(:success?)

    Operation::Result.new(value)
  end

  def fail!(klass, *args)
    Operation::Result.new(nil, { klass => args })
  end
end
