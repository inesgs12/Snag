# frozen_string_literal: true

class Keg < ApplicationRecord
  belongs_to :floor
  belongs_to :beer

  def self.refresh
    Keg.update_all(status:3,updated_at:Date.today)
  end
end
