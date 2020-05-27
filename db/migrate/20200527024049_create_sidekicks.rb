class CreateSidekicks < ActiveRecord::Migration[6.0]
  def change
    create_table :sidekicks do |t|
      t.string :name
      t.string :superpower
      t.integer :superhero_id
    end
  end
end
