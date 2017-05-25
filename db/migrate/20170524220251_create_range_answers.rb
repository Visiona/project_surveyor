class CreateRangeAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :range_answers do |t|
      t.integer :user_id, :null => false
      t.integer :value, :null => false
      t.integer :range_q_and_c_id, :null => false

      t.timestamps
    end
    add_index :range_answers, [:user_id, :range_q_and_c_id], unique: true
    add_foreign_key :range_answers, :range_q_and_cs
  end
end
