# frozen_string_literal: true

module UsersServices
  module SetModel
    class Transaction < MainService
      step :validate_params
      step :find_user

      def validate_params(params)
        validation = Contract.call(params.permit!.to_h)
        if validation.success?
          Success(params)
        else
          Failure[I18n.t('params.invalid'), validation.errors.to_h]
        end
      end

      def find_user(params)
        user = User.where(
          id: params[:id]
        ).first
        if user.present?
          Success(user)
        else
          Failure(user.errors.full_messages.to_sentence)
        end
      end
    end
  end
end
