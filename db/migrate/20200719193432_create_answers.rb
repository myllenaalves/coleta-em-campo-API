class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.string :formulary_id
      t.string :question_id
      t.string :visit_id
      t.datetime :answered_at

      t.timestamps
    end
  end
end
