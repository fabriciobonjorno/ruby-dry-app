# frozen_string_literal: true

module UsersServices
  module Update
    class Transaction < MainService
      step :validate_params
      step :update_user

      def validate_params(params)
        @params = params[:params]
        @model = params[:model]

        validation = Contract.call(@params.permit!.to_h)
        if validation.success?
          Success[@params, @model]
        else
          Failure[I18n.t('params.invalid'), validation.errors.to_h]
        end
      end

      def update_user(input)
        params = input[0]
        user = input[1]

        user.name = params[:name] if params[:name]
        user.email = params[:email] if params[:email]

        if user.save
          response = {
            id: user.id.to_s,
            name: user.name,
            email: user.email,
            registered_at: user.created_at.strftime('%d/%m/%Y %H:%M')
          }
          Success(response)
        else
          Failure(user.errors.full_messages.to_sentence)
        end
      end
    end
  end
end
