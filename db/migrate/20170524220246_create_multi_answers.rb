class CreateMultiAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :multi_answers do |t|
      t.integer :user_id, :null => false
      t.integer :choice_id, :null => false
      t.integer :multi_q_id, :null => false

      t.timestamps
    end
      add_index :multi_answers, [:user_id, :choice_id, :multi_q_id], unique: true
  end
end
