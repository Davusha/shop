class Register
  include Interactor

  def call
    unless context.password == context.password_confirmation
      context.fail!(message: "Введенные пароли не совпадают")
    end

    if User.find_by(email: context.email) || User.find_by(name: context.name)
      context.fail!(message: "Пользователь с email и/или именем уже существует")
    elsif User.find_by(phone: context.phone)
      context.fail!(message: "Пользователь с телефоном уже существует")
    end

    password = Digest::SHA1.hexdigest context.password
    user = User.new(
        email: context.email,
        name: context.name,
        password: password,
        phone: context.phone
    )

    context.fail!(message: "Проверьте правильность введенных данных") unless user.save

    context.user = user
  end
end
