# frozen_string_literal: true

module Operation
  module ControllerHelpers
    def call_operation(opc, **args)
      result = opc.new(**args).call
      if block_given?
        yield(result)
      else
        result
      end
    end
  end
end
