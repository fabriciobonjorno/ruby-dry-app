# frozen_string_literal: true

module UsersServices
  module Create
    class Transaction < MainService
      step :validate_params
      step :check_user
      step :check_phone
      step :create_user
      step :add_address_user
      step :add_phone_user
      step :output

      def validate_params(params)
        validation = Contract.call(params.permit!.to_h)

        if validation.success?
          Success(params)
        else
          Failure[I18n.t('params.invalid'), validation.errors.to_h]
        end
      end

      def check_user(params)
        email = User.where(email: params[:user][:email])
        username = User.where(username: params[:user][:username])
        if email.exists?
          Failure I18n.t('user.validates.email')
        elsif username.exists?
          Failure I18n.t('user.validates.username')
        else
          Success(params)
        end
      end

      def check_phone(params)
        phone = Phone.where(number: params[:phone][:number])
        if phone.exists?
          Failure I18n.t('phone.validates.phone')
        else
          Success(params)
        end
      end

      def create_user(params)
        user = params[:user]
        new_user = User.new
        new_user.name = user[:name]
        new_user.email = user[:email]
        new_user.password = user[:password]
        new_user.username = user[:username]

        if new_user.save
          params[:user_id] = new_user.id
          Success(params)
        else
          Failure(new_user.errors.full_messages.to_sentence)
        end
      end

      def add_address_user(params)
        user = User.find(params[:user_id])
        address = params[:address]
        new_address = user.build_address(address)
        if new_address.save
          Success(params)
        else
          Failure(new_address.errors.full_messages.to_sentence)
        end
      end

      def add_phone_user(params)
        user = User.find(params[:user_id])
        phone = params[:phone]
        new_phone = user.build_phone(phone)
        if new_phone.save
          Success(params)
        else
          Failure(new_phone.errors.full_messages.to_sentence)
        end
      end

      def output(params)
        user = User.find(params[:user_id])
        phone = user.phone
        address = user.address
        response = {
          user: {
            name: user.name,
            username: user.username,
            email: user.email,
            address: {
              address: address.address,
              address_number: address.address_number,
              complement: address.complement,
              city: address.city,
              state: address.state,
              zip_code: address.zip_code
            },
            phone: {
              kind: phone.kind,
              number: phone.number
            },
            registered_at: user.created_at.strftime('%d/%m/%Y')
          }
        }
        Success(response)
      end
    end
  end
end
