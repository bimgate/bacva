class AddTypeOfWineColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :type_of_wine, :string
  end
end
