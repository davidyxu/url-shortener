class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :original_link
      t.string :shortened_link
      t.integer :user_id
    end
  end
end
