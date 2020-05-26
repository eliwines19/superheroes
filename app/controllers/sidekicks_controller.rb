class SidekickController < ApplicationController

  get "/sidekicks" do
    redirect_if_not_logged_in
    @sidekicks = Sidekick.all
    erb :'sidekicks/index'
  end

  get "/sidekicks/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'sidekicks/new'
  end

  get "/sidekicks/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @sidekick = Sidekick.find(params[:id])
    erb :'sidekicks/edit'
  end

  post "/sidekicks/:id" do
    redirect_if_not_logged_in
    @sidekick = Sidekick.find(params[:id])
    unless Sidekick.valid_params?(params)
      redirect "/sidekicks/#{@sidekick.id}/edit?error=invalid sidekick"
    end
    @sidekick.update(params.select{|s|s=="name" || s=="superpower" || s=="superhero_id"})
    redirect "/sidekicks/#{@sidekick.id}"
  end

  get "/sidekicks/:id" do
    redirect_if_not_logged_in
    @sidekick = Sidekick.find(params[:id])
    erb :'sidekicks/show'
  end

  post "/sidekicks" do
    redirect_if_not_logged_in
    unless Sidekick.valid_params?(params)
      redirect "/sidekicks/new?error=invalid sidekick"
    end
    Sidekick.create(params)
    redirect "/sidekicks"
  end
end
