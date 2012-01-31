class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :user
      t.text :tweet

      t.timestamps
    end
  end
end
