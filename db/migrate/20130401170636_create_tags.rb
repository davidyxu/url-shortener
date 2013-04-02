class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.integer :user_id
      t.integer :link_id
    end
  end
end
