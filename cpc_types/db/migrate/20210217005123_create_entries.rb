class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :account, null: false, foreign_key: true
      t.string :tags
      t.string :entryable_type
      t.integer :entryable_id

      t.timestamps
    end
  end
end
