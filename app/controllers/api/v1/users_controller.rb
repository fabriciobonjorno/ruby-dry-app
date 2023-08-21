# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        UsersServices::Create::Transaction.call(params) do |on|
          on.failure(:validate_params) { |message, content| render json: { message:, content: }, status: 400 }
          on.failure(:check_user) { |message, content| render json: { message:, content: }, status: 400 }
          on.failure(:check_phone) { |message, content| render json: { message:, content: }, status: 400 }
          on.failure(:create_user) { |message| render json: { message:, content: {} }, status: 500 }
          on.failure(:add_address_user) { |message| render json: { message:, content: {} }, status: 500 }
          on.failure(:add_phone_user) { |message| render json: { message:, content: {} }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end
    end
  end
end
