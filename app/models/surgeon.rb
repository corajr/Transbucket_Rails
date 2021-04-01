class Surgeon < ActiveRecord::Base
  include SanitizeNames
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  has_many :pins
  has_many :skills
  has_many :procedures, through: :skills

  scope :has_procedures, -> { joins(:procedures).
                              group('surgeons.id').
                              having('count(procedures.id) > 0') }

  phony_normalize :phone, default_country_code: 'US'

  validates :last_name, uniqueness: { scope: :first_name }
  validates :last_name, presence: true

  def full_name
    "#{last_name}-#{first_name}"
  end

  def pretty_name
    "#{last_name}, #{first_name}"
  end

  def overall_satisfaction
    # 0 means unrated basically
    Pin.where(surgeon_id: id).where.not(satisfaction: 0).average(:satisfaction)
  end

  def satisfaction_by_procedure
    Pin.where(surgeon_id: id).where.not(satisfaction: 0).
      group([:procedure_id]).average(:satisfaction)
  end

  def to_s
    first_name.nil? ? last_name : last_name.capitalize + ', ' + first_name.capitalize
  end

  def self.names
    pluck(:first_name, :last_name).
      collect! {|e| e[0].nil? ? e[1] : e.reverse.join(', ') }.
      sort
  end
end
