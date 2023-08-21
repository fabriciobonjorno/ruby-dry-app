# frozen_string_literal: true

class Address < ApplicationRecord
  # validates
  validates :zip_code, :address, :address_number, presence: true
  validates :state, :city, :neighborhood, presence: true

  # relationships
  belongs_to :addressable, polymorphic: true
end
