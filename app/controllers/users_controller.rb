class UsersController < ApplicationController
  protect_from_forgery with: :exception

  # Add a new user to the system and return to the creation page or kick the person back to the page with an error
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

  # Show the user a page for adding other users
  def create
    # Create a new UserRecord called @user and pass it to the "create.erb" view
    @user = UserRecord.new
  end

  # Show the user a login page (or take them back to where they came from if already logged in)
  def login
    # Make a blank UserRecord called @user and pass it to the "login.erb" view
    @user = UserRecord.new

    # Set the redirect to dashboard if there is none registered
    if request.referer && request.referer != users_login_path
      # If :return_to is not explicitly set and this page has an external referer, redirect there
      session[:return_to] ||= request.referer
    else
      # If the user directly requested the login page, send them to the dashboard
      # TODO: This should be the dashboard (currently a WIP)
      session[:return_to] ||= '/dashboard'
    end
    puts request.referer

    if session[:user_id] != nil
      # Redirect to last page or the dashboard if no :return_to registered
      redirect_to session.delete :return_to
      puts 'Already logged in'
    end
  end

  # Log the user in or kick them back to the login page with an error message
  def do_login
    @user = UserRecord.new(params[:user].permit(:username, :password))

    # Manually validate the username and password fields
    # TODO: Check for SQL injection here
    if @user.username.to_s.empty?
      @user.errors.add(:username, :blank)
    end
    if params[:user]['password'].to_s.size < 6
      @user.errors.add(:password, :too_short, count:6)
    end

    # If the username and password could be valid, attempt to authenticate
    if @user.errors.size == 0
      # Look up the user and check the salted hash
      @authenticated_user = UserRecord.find_by_username(@user.username).authenticate(params[:user]['password'])
      if @authenticated_user
        session[:user_id] = @authenticated_user.id
        # Redirect to last page (or the dashboard if none was found / specified)
        redirect_to session.delete :return_to
      else
        # Could not authenticate the user's credentials -- say this and take them back to the login page
        @user.errors.add(:base, :not_implemented, message: 'Incorrect username or password')
        render :login
      end
    else
      # Otherwise, render the view for "login" again with errors
      render :login
    end
  end
end
