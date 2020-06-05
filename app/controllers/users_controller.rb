class UsersController < ApplicationController

  get '/signup' do
      if !logged_in?
          erb :'/users/new'
      else
          redirect to '/superheroes'
      end
  end

  post '/signup' do
      if params[:username] == "" || params[:password] == ""
          redirect to '/signup'
      else
          @user = User.create(:username => params[:username], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          redirect to '/superheroes'
      end
  end

  get '/login' do
      if !logged_in?
          erb :'/users/login'
      else
          redirect to '/superheroes'
      end
  end

  post '/login' do
      @user = User.find_by(:username => params[:username])

      if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/superheroes'
      else
          redirect to '/signup'
      end
  end

  get '/users/heroes' do
    if logged_in?
      @heroes = current_user.superheros
      erb :'/users/heroes'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
      if logged_in?
          logout!
          redirect to '/login'
      else
          redirect to '/'
      end
  end

end
