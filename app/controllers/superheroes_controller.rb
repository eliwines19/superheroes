class SuperheroController < ApplicationController

  get "/superheroes" do
    redirect_if_not_logged_in
    @superheroes = Superhero.all
    erb :'superheroes/index'
  end

  get "/superheroes/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'superheroes/new'
  end

  get "/superheroes/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @superhero = Superhero.find(params[:id])
    erb :'superheroes/edit'
  end

  post "/superheroes/:id" do
    redirect_if_not_logged_in
    @superhero = Superhero.find(params[:id])
    unless Superhero.valid_params?(params)
      redirect "/superheroes/#{@superhero.id}/edit?error=invalid hero"
    end
    @superhero.update(params.select{|s|s=="name" || s=="superpower"})
    redirect "/superheroes/#{@superhero.id}"
  end

  get "/superheroes/:id" do
    redirect_if_not_logged_in
    @superhero = Superhero.find(params[:id])
    erb :'superheroes/show'
  end

  post "/superheroes" do
    redirect_if_not_logged_in

    unless Superhero.valid_params?(params)
      redirect "/superheroes/new?error=invalid hero"
    end
    Superhero.create(params)
    redirect "/superheroes"
  end
end
