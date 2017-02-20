class ResortToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :password_digest, :string, after: :email
  end
end
