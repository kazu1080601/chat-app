class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user, foregin_key:true
      t.references :room, foregin_key:true
      t.timestamps
    end
  end
end
