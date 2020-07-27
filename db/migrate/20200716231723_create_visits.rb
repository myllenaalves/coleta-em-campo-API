class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.string :user_id
      t.datetime :date
      t.string :status
      t.datetime :checkin_at
      t.datetime :checkout_at
      t.timestamps
    end
  end
end
