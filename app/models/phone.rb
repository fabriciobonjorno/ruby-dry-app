# frozen_string_literal: true

class Phone < ApplicationRecord
  belongs_to :phoneble, polymorphic: true
end
