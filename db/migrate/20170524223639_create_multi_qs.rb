class CreateMultiQs < ActiveRecord::Migration[5.0]
  def change
    create_table :multi_qs do |t|
      t.string :question, :null => false
      t.integer :survey_id, :null => false

      t.timestamps
    end
    add_index :multi_qs, [:question, :survey_id]
  end
end
