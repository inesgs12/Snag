# frozen_string_literal: true
class Request < ApplicationRecord
  belongs_to :requester, :class_name => :User, :foreign_key => "requester_id"
  belongs_to :snagger, :class_name => :User, :foreign_key => "snagger_id", optional: true
  belongs_to :beer
  belongs_to :location

  validate :cannot_snag_own_beer
  validates :status, inclusion: { in: ["open", "closed", "in progress", "cancelled", "bailed"]}

  def cannot_snag_own_beer
    if requester_id == snagger_id
      errors.add(:snagger, "cannot be the same as requester, that's what friend are for!")
    end
  end

  def self.open
    Request.all.select{ |request| request.status == "open" && (request.updated_at + 2.hours).future?  }
      .sort_by{ |request| request.updated_at}
  end

  def self.bar_open?
    (15...24).include?(Time.now.hour) ? true : false
  end


  def self.timecheck
    today = Date.today
    hour = Time.now.hour

    if Keg.first.updated_at < today
      Keg.refresh
      Request.cancel_overnight_orders
    end
  end

  def self.cancel_overnight_orders
    remaining = all.each do |request|
      if request.created_at < (Date.today-1) && request.status == "/[open|in progress]/"
        request.update(status:"cancelled")
      end
    end
  end

end
