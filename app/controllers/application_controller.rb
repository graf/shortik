# frozen_string_literal: true

class ApplicationController < ActionController::API
  def call_operation(opc, **args)
    result = opc.new(**args).call
    if block_given?
      yield(result)
    else
      result
    end
  end
end
