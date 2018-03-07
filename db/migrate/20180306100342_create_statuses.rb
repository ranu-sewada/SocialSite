class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.integer :post_id
      t.integer :user_id
      t.boolean :like

      t.timestamps
    end
  end
end
