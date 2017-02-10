class NewListingFormat < ActiveRecord::Migration

  def change
  	remove_column("listings", "variety", :string)
  	remove_column("listings", "year", :integer)
  	remove_column("listings", "flow", :string)
  	remove_column("listings", "pressure", :string)
  	remove_column("listings", "category", :string)
  	
  	add_column("listings", "macro_category", :string)
  	add_column("listings", "category", :string)
  	add_column("listings", "sub_category", :string)
  	add_column("listings", "short_description", :string, limit: 70)
  	add_column("listings", "long_description", :string)
  	add_column("listings", "classification", :string)
  	add_column("listings", "key_definition", :string, limit: 30)
  	add_column("listings", "properties", :string)
  	add_column("listings", "brand", :string)
  	add_column("listings", "equipment", :string, :default => "-")
  	add_column("listings", "notes", :string, :default => "-")
  	add_column("listings", "measurements", :string)
  	add_column("listings", "quantity", :integer)
  	add_column("listings", "state", :string)

  end

end

# Column migration methods:
# add_column(table, column, type, options)
# remove_column(table, column)
# rename_column(table, column, new_name)
# change_column(table, column, type, options) --> NB: bisogna specificare ogni caratteristica della nuova colonna, comprese quelle precedenti che non vogliamo che cambino altrimenti tutte quelle non citate nella nuova versione vengono eliminate

# Index migration methods:
# add_index(table, column, options)
# remove_index(table, column)
# --> Index options:
# 			:unique => true/false
# 			:name => "your_custom_name"