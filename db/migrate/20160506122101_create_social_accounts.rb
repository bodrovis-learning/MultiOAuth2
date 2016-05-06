class CreateSocialAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :social_accounts do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :provider, index: true
      t.string :uid, index: true

      t.timestamps
    end

    add_index :social_accounts, [:provider, :uid], unique: true
  end
end
