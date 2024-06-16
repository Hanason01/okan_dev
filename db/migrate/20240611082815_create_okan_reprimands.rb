class CreateOkanReprimands < ActiveRecord::Migration[7.0]
  def change
    create_table :okan_reprimands do |t|
      t.string :body, null: false

      t.timestamps
    end
  end
end
