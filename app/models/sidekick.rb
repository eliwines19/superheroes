class Sidekick < ActiveRecord::Base
  belongs_to :superhero

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:superpower].empty?
  end
end
