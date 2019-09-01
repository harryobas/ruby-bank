class Contexts::UserRegister

  def self.call(email, password)
    unless email.present? and password.present?
      return {error: "missing data"}
    end 
    new(email, password).call
  end

  def initialize(email, password)
    @email = email
    @password = password
    @user = User
    assign_registrar(@user)
  end

  def call
    @registrar.register_user( @password, @email)
  end

  private

  def assign_registrar(user)
     @registrar = Registrar.new(user)
  end

  class Registrar < SimpleDelegator
    def register_user(password, email)
      if user = self.create(email: email, password: password, account: Account.create)
        return {
          message: "user created",
          id: user.id,
          account_id: user.account.id
        }
      else
        return {error: user.errors.full_messages}
      end
    end
  end
end
