class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :original_link
      t.string :shortened_link
      t.integer :user_id
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
    end
  end
end

class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :link_id
      t.string :user_id

      t.timestamps
    end
  end
end

class CreateTags < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :name
    end
  end
end
end