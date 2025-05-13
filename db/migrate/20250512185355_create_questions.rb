class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :survey
      t.integer :question_type, null: false, default: 0
      t.json :options, null: false, default: []
      t.check_constraint "JSON_TYPE(options) = 'array'", name: "question_options_is_array"
      t.text :body, null: false, default: ""

      t.timestamps
    end
  end
end
