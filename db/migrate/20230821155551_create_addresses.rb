# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :zip_code
      t.string :address
      t.string :address_number
      t.string :complement
      t.string :state
      t.string :city
      t.string :neighborhood
      t.references :addressable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
