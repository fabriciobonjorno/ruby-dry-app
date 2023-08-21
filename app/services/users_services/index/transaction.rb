# frozen_string_literal: true

module UsersServices
  module Index
    class Transaction < MainService
      step :output

      def output
        users = User.all
        response = users.map do |user|
          {
            id: user.id.to_s,
            name: user.name,
            email: user.email,
            registered_at: user.created_at.strftime('%d/%m/%Y %H:%M')
          }
        end
        Success(response)
      end
    end
  end
end
