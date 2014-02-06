class PasswordController < Devise::PasswordsController
  def create
   if User.where(email: params[:user][:email]).exist?
    super
    @mail = resource.email
   else
    respond_with(resource)
   end
  end

  def new
   super
  end

  def edit
   super
  end

  def update
   super
  end
end
