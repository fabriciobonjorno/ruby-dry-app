# frozen_string_literal: true

module UsersServices
  module Destroy
    class Transaction < MainService
      step :destroy_model

      def destroy_model(user)
        if user.destroy
          Success(I18n.t('user.destroy.success'))
        else
          Failure(user.errors.full_messages.to_sentence)
        end
      end
    end
  end
end
