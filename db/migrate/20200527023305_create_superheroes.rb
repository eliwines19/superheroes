class CreateSuperheroes < ActiveRecord::Migration[6.0]
  def change
    create_table :superheros do |t|
      t.string :name
      t.string :superpower
      t.integer :user_id
    end
  end
end
