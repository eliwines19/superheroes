class Superhero < ActiveRecord::Base
  has_many :sidekicks
  belongs_to :user

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:superpower].empty?
  end
end
