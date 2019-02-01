class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: visitor.id) if visitor
  end

  private

  attr_accessor :email, :password

  def visitor
    visitor = Visitor.find_by_email(email)
    return visitor if visitor && visitor.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
