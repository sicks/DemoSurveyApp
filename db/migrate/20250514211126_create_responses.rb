class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.references :user
      t.references :survey
      t.datetime :completed_at

      t.timestamps
    end
  end
end
