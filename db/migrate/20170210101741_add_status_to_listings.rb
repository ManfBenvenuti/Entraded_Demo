class AddStatusToListings < ActiveRecord::Migration

  def up
    add_column :listings, :status, :string
  end

  def down
    remove_column :listings, :status
  end

end
