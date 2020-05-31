class SuperheroController < ApplicationController

  get '/superheroes' do
    if logged_in?
      @superheroes = Superhero.all
      erb :'superheroes/index'
    else
      redirect to '/login'
    end
  end

  get '/superheroes/new' do
    if logged_in?
      erb :'/superheroes/new'
    else
      redirect to '/login'
    end
  end

  post '/superheroes' do
      if logged_in?
          if params[:name] == ""
              redirect to "superheroes/new"
          else
              @superhero = Superhero.new(params)
              @superhero.user = current_user
              if @superhero.save
                  redirect to "/superheroes/#{@superhero.id}"
              else
                  redirect to '/superheroes/new'
              end
          end
      else
          redirect to "/login"
      end
  end

  get '/superheroes/:id' do
    if logged_in?
      @superhero = Superhero.find_by_id(params[:id])
      erb :'/superheroes/show'
    else
      redirect to '/login'
    end
  end

  get '/superheroes/:id/edit' do
    @superhero = Superhero.find_by_id(params[:id])
    if logged_in? && current_user = @superhero.user
      erb :'/superheroes/edit'
    else
      redirect to '/login'
    end
  end

  patch '/superheroes/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/superheroes/#{params[:id]}/edit"
      else
        @superhero = Superhero.find_by_id(params[:id])
        if @superhero && @superhero.user == current_user
          if @superhero.update(name: params[:name], superpower: params[:superpower], motto: params[:motto], suit_color: params[:suit_color], city: params[:city], age: params[:age])
            redirect to "/superheroes/#{@superhero.id}"
          else
            redirect to "/superheroes/#{@superhero.id}.edit"
          end
        else
          redirect to '/superheroes'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/superheroes/:id/delete' do
    if logged_in?
      @superhero = Superhero.find_by_id(params[:id])
      if @superhero && @superhero.user == current_user
        @superhero.delete
      end
      redirect to '/superheroes'
    else
      redirect to '/login'
    end
  end


end
