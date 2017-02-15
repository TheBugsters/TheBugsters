class UsersController < ApplicationController
  protect_from_forgery with: :exception

  def add
    # Create a UserRecord object from the parameters posted by the form
    @user = UserRecord.new(params[:user].permit(:name, :username, :email, :password, :password_confirmation))
    # Try to add the record to the database, running the validations required by the model
    if @user.save
      # If successful, take us back to the new user page (we might want to make another)
      redirect_to :action => 'create'
    else
      # Otherwise, render the view for "create" again (i.e. use the same @user object)
      # This automatically passes errors since they are stored in @user.errors.
      # See the view code for how our (basic) error handling works
      render :create
    end
  end
  def create
    # Create a new UserRecord called @user and pass it to the "create.erb" view
    @user = UserRecord.new
  end
end
