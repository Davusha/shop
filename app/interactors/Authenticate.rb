class Authenticate
  include Interactor

  def call
    password = Digest::SHA1.hexdigest context.password

    if (user = User.find_by(email: context.email, password: password))
      context.user = user
    else
      context.fail!(message: "Неправильно указан email и/или пароль")
    end
  end
end
