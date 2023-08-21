# frozen_string_literal: true

module UsersServices
  module Show
    class Transaction < MainService
      step :output

      def output(user)
        response = {
          id: user.id.to_s,
          name: user.name,
          email: user.email,
          registered_at: user.created_at.strftime('%d/%m/%Y %H:%M')
        }
        Success(response)
      end
    end
  end
end
