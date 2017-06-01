class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.integer :multi_q_id, :null => false
      t.string :name

      t.timestamps
    end
    add_index :choices, :name
  end
end
