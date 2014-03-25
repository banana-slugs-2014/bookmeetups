class UserBuilder
  def initialize(params = {})
    @username               = params[:username]
    @password               = params[:password]
    @password_confirmation  = params[:password_confirmation]
    @email                  = params[:email]
  end

  def build
    new_user = User.new do |user|
      user.username               = @username
      user.password               = @password
      user.password_confirmation  = @password_confirmation
      user.email                  = @email
    end
    return new_user
  end
end