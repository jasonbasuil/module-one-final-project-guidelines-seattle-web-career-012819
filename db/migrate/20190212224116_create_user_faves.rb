class CreateUserFaves < ActiveRecord::Migration[5.0]
  def change
    create_table :user_faves do |t|
      t.integer :user_id
      t.integer :fave_animal_id 
    end
  end
end
