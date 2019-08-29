class Contexts::UserRegister

  def self.call(email, password)
    if !email.present? || password.nil?
      return {error: "something went wrong"}
    end
    new(email, password).call
  end

  def initialize(email, password)
    @user = User.new(email: email, password: password)
    assign_registrar(@user)
  end

  def call
    @registrar.register_user
  end

  private

  def assign_registrar(user)
    @registrar = Registrar.new(user)
  end

  class Registrar < SimpleDelegator
    def register_user
      #self.account = Account.new if self
      if self.save
        return {message: "user created", user: self.email}
      else
        return {error: self.errors.full_messages}
      end
    end
  end

end
