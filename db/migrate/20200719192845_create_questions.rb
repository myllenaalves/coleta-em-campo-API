class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :formulary_id
      t.string :question_type

      t.timestamps
    end
  end
end
