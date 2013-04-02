class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :link_id
      t.string :user_id

      t.timestamps
    end
  end
end
