class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.datetime :date
      t.string :status
      t.datetime :checkin_at
      t.datetime :checkout_at
      t.belongs_to :user
      t.timestamps
    end
  end
end
