# frozen_string_literal: true

class Phone < ApplicationRecord
  # validates
  validates :kind, :number, presence: true
  validates :number, uniqueness: { case_sensitive: false }

  # enumerates
  enum kind: %i[personal commercial]

  # relationships
  belongs_to :phoneble, polymorphic: true
end
