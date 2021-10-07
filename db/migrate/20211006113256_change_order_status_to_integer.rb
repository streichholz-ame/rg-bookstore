class ChangeOrderStatusToInteger < ActiveRecord::Migration[6.0]
  def up
    def change
      change_column :orders, :status, :integer, using: 'status::integer'
    end
  end

  def down
    def change
      change_column :orders, :status, :string
    end
  end
end
