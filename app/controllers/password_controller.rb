class PasswordController < Devise::PasswordsController
  def create
   super
   @mail = resource.email
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
