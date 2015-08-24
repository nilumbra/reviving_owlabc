class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.attachment :avatar
      t.string :phone
      t.string :wechat
      t.string :qq
      t.integer :user_id
      t.timestamps
    end
  end
end
