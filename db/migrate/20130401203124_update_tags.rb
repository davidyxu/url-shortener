class UpdateTags < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.remove :tag_name, :user_id
      t.integer :tag_type_id
    end
    create_table :tag_types do |t|
      t.string :tag_name
    end
  end
end
