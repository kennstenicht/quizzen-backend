module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
    end

    protected

    def find_user
      token = request.params[:token]
      user = Knock::AuthToken.new(token: token).entity_for(User) if token

      return user if user
    end
  end
end
