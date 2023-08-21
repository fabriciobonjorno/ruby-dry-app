# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_model, only: %i[show update destroy]
      def index
        UsersServices::Index::Transaction.call do |on|
          on.failure(:validate_params) { |message, content| render json: { message:, content: }, status: 400 }
          on.failure { |response| render json: { message: response }, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

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

      def show
        UsersServices::Show::Transaction.call(@model) do |on|
          on.failure(:validate_params) { |message, content| render json: { message:, content: }, status: 400 }
          on.failure(:find_user) { |message| render json: { message: }, status: 404 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

      def update
        UsersServices::Update::Transaction.call({ params:, model: @model }) do |on|
          on.failure(:validate_params) { |message, content| render json: { message:, content: }, status: 400 }
          on.failure(:update_user) { |message| render json: { message: }, status: 404 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

      def destroy
        UsersServices::Destroy::Transaction.call(@model) do |on|
          on.failure { |response| render json: { message: response }, status: 500 }
          on.success { |response| render json: { message: response }, status: 200 }
        end
      end

      private

      def set_model
        @model = UsersServices::SetModel::Transaction.call(params) do |on|
          on.failure(:validate_params) { |message, content| return render json: { message:, content: }, status: 400 }
          on.failure(:find_user) { |message| return render json: { message: }, status: 404 }
          on.failure { |response| return render json: response, status: 500 }
          on.success { |response| response }
        end
      end
    end
  end
end
