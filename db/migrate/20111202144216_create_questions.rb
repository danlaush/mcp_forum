class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :content
      t.string :name
      t.string :entity
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
