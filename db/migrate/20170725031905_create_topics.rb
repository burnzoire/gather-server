class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.references :forum, foreign_key: true
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
