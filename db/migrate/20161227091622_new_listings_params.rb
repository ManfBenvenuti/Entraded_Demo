class NewListingsParams < ActiveRecord::Migration

  def up

  	remove_column("listings", "name")
    add_column("listings", "category", :string)
  	add_column("listings", "variety", :string, :limit => 150)
  	add_column("listings", "flow", :string, :limit => 200)
  	add_column("listings", "pressure", :string, :limit => 150)
  	add_column("listings", "year", :integer, :limit => 5)


  end

  def down

    add_column("listings", "name", :string)
    remove_column("listings", "category", :string)
  	remove_column("listings", "variety")
  	remove_column("listings", "flow")
  	remove_column("listings", "pressure")
  	remove_column("listings", "year")

  end


end
