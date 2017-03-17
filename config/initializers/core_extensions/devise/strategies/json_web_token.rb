module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        body = claims
        return fail! unless body
        return fail! unless body.has_key?('admin_id') && body.has_key?('exp')
        return fail! unless Time.at(body['exp']) > Time.now

        resource = Admin.find_by(id: body['admin_id'])
        return fail! unless resource

        success! resource
      end

      protected

      def claims
        strategy, token = request.headers['Authorization'].split(' ')

        return nil if (strategy || '').downcase != 'bearer'

        JWTWrapper.decode(token) rescue nil
      end
    end
  end
end
