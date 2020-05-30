class Superhero < ActiveRecord::Base
  belongs_to :user

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:superpower].empty?
  end

end
