class CreateReposts < ActiveRecord::Migration[6.1]
  def change
    create_table :reposts do |t|
      t.references :post

      t.timestamps
    end
  end
end
