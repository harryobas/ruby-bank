class Contexts::UserRegister

  def self.call(password)
    new(password).call
  end

  def initialize(password)
    @password = password
    @user = User
    assign_registrar(@user)
  end

  def call
    @registrar.register_user( @password)
  end

  private

  def assign_registrar(user)
     @registrar = Registrar.new(user)
  end

  class Registrar < SimpleDelegator
    def register_user(password)
      user = self.create(password: password, account: Account.new)

      return {
        message: "user created",
        id: user.id,
        account_id: user.account.id
      } if user

      {error: user.errors.full_messages}

    end
  end
end
