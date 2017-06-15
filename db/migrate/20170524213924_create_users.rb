class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      # t.integer :survey_id

      t.timestamps
    end
    add_foreign_key :survey, :survey_id
  end
end
