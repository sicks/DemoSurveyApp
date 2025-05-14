class AddOptionLayoutToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :option_layout, :integer, null: false, default: 0
  end
end
