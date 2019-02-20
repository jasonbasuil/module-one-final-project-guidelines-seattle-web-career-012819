class CreateFavoriteAnimals < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_animals do |t|
      t.string :animal_key
      t.string :status
      t.string :name
      t.string :species
      t.string :breed
      t.string :age
      t.string :image
      t.string :website
    end
  end
end
