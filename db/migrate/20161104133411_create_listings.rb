# Creata con:
# rails generate scaffold Listing name:string description:text price:decimal
# rails g scaffold crea migrazione, modello, view, controller, tester e helper del controller.

class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.text :description
      t.decimal :price

      t.timestamps null: false
    end
  end
end
