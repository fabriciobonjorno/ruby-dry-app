# frozen_string_literal: true

module UsersServices
  module Update
    class Contract < ApplicationContract
      params do
        optional(:name).filled(:str?)
        optional(:email).filled(:str?)
      end
    end
  end
end
