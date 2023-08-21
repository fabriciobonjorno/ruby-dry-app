# frozen_string_literal: true

module UsersServices
  module SetModel
    class Contract < ApplicationContract
      params do
        required(:id).filled(:str?)
      end
    end
  end
end
