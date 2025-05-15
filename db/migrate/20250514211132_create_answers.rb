class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.references :question
      t.references :response
      t.string :body, null: false, default: ""
      t.json :picks, null: false, default: []
      t.check_constraint "JSON_TYPE(picks) = 'array'", name: "answer_picks_is_array"

      t.timestamps
    end
  end
end
