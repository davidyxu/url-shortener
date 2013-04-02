class UpdateLinks < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.integer :long_url_id
      t.remove :original_link
    end

    create_table :long_urls do |t|
      t.string :url
    end
  end
end
