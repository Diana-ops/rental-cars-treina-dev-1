class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :license_plate
      t.string :color
      t.references :car_model, null: false, foreign_key: true
      t.integer :mileage
      t.references :subsidiary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
