# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :requests

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true

  def currently_snagging
    Request.find_by(snagger: self, status: 'in progress')
  end

  def currently_requesting
    Request.find_by(requester: self, status: ['open', 'in progress'])
  end

  def completed_snags
    snags = Request.where(snagger: self, status: 'closed')
    if !snags.empty?
      snags
    else
      []
    end
  end

  def fulfilled_requests
    requests = Request.where(requester: self, status: 'closed')
    if !requests.empty?
      requests
    else
      []
    end
  end

  def snag_ratio
    ratio = completed_snags.length.to_f / fulfilled_requests.length
    if !completed_snags.empty? && fulfilled_requests.empty?
      1.0
    elsif fulfilled_requests.empty?
      0.0
    else
      ratio
    end
  end

  def unique_receivers
    completed_snags.map(&:requester)
  end

  def bailed_snags
    Request.where(snagger:self, status:"bailed")
  end

  private

  def new_user?
    new_record?
  end
end
