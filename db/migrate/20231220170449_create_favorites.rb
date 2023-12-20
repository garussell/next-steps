class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.string :category
      t.string :name
      t.string :description
      t.string :address
      t.string :website
      t.string :phone
      t.string :fees
      t.string :schedule

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
