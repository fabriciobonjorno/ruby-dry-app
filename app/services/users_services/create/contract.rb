# frozen_string_literal: true

module UsersServices
  module Create
    class Contract < ApplicationContract
      params do
        required(:user).hash do
          required(:name).filled(:str?)
          required(:username).filled(:str?)
          required(:email).filled(:str?)
          required(:password).filled(:str?)
          required(:password_confirmation).filled(:str?)
        end

        required(:address).hash do
          required(:zip_code).filled(:str?)
          required(:address).filled(:str?)
          required(:address_number).filled(:str?)
          required(:neighborhood).filled(:str?)
          required(:state).filled(:str?)
          required(:city).filled(:str?)
        end

        required(:phone).hash do
          required(:kind).filled(:integer)
          required(:number).filled(:str?)
        end
      end

      rule(:user) do
        key.failure('email has invalid format') unless /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i.match?(values[:user][:email])
        key.failure('username has invalid format') unless /\A[a-z0-9_]{3,15}\z/.match?(values[:user][:username])

        key.failure('passwords must be the same') unless values[:user][:password] == values[:user][:password_confirmation]

        unless /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{8,}\z/.match?(values[:user][:password])
          key.failure('password should have more than 8 characters including 1 uppercase letter, 1 number, 1 special character')
        end
      end
    end
  end
end
