class Contexts::UserLogin
  def self.call(email, password)
    new(email, password).call
  rescue ActiveRecord::RecordNotFound => e
    return {error: "#{email} not found"}
  end

  def initialize(email, password)
    @email = email
    @password = password
    @user = User.find_by(email: @email)
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
