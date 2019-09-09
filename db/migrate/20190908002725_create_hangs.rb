class CreateHangs < ActiveRecord::Migration[6.0]
  def change
    create_table :hang_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :hangs do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.belongs_to :owner, null: false, foreign_key: { to_table: :users }, index: true
      t.belongs_to :hang_type, null: false, foreign_key: true

      t.timestamps
    end

    create_table :hang_subscriptions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :hang_type, null: false, foreign_key: true

      t.timestamps
    end

    create_table :hang_participants do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :hang, null: false, foreign_key: true

      t.timestamps
    end

    add_index :hang_subscriptions, [:user_id, :hang_type_id], unique: true
    add_index :hang_participants, [:user_id, :hang_id], unique: true
  end
end
