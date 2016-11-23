class CreateHeros < ActiveRecord::Migration[5.0]
  def change
    create_table :heros do |t|
      t.belongs_to :user, index: true
      t.string :name, default: 'UnknowHero'
      t.integer :hp, default: 100
      t.integer :atk, default: 10
      t.integer :def, default: 5

      t.timestamps
    end
  end
end
