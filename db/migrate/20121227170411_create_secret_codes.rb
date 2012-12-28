class CreateSecretCodes < ActiveRecord::Migration
  def change
    create_table :secret_codes do |t|
      t.string :code
      t.references :user

      t.timestamps
    end
    add_index :secret_codes, :user_id
  end
end
