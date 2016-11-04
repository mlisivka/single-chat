class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :email
      t.string   :last_transition
      t.string   :provider
      t.string   :uid
      t.boolean  :online

      t.timestamps
    end
  end
end
