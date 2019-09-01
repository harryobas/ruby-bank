class Contexts::UserLogin
  def self.call(email, password)
    new(email, password).call
  rescue StandardError => e
    return {:error => e.message}
  end

  def initialize(email, password)
    @password = password
    @email = email
    begin
      @user = User.find_by!(email: @email)
    rescue ActiveRecord::RecordNotFound => e
      raise StandardError.new("#{email} not found")
    end
    assign_authenticator(@user)
  end

  def call
    @authenticator.authenticate_user(@password)
  end

  private

  def assign_authenticator(auth)
    @authenticator = Authenticator.new(auth)
  end

  class Authenticator < SimpleDelegator
    def authenticate_user(password)
      if self.authenticate(password)
        jwt = Auth.issue({user: self.id})
        return {jwt: jwt, user: self.email}
      else
        return {message:'The password provided is incorrect'}
      end
    end

  end

end
