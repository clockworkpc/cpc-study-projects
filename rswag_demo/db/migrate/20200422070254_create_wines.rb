class CreateWines < ActiveRecord::Migration[6.0]
  def change
    create_table :wines do |t|
      t.string :name
      t.array :grapes
      t.enum :type

      t.timestamps
    end
  end
end
