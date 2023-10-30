class AddRemovedToTrades < ActiveRecord::Migration[7.0]
  def change
    add_column :trades, :removed, :boolean, default: false
  end
end
