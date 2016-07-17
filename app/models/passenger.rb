# == Schema Information
#
# Table name: passengers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  map_id     :integer
#  row        :integer          not null
#  col        :integer          not null
#  dest_row   :integer          not null
#  dest_col   :integer          not null
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Passenger < ActiveRecord::Base
  belongs_to :taxi
  belongs_to :map

  enum status: [:calling, :waiting, :going]

  scope :not_going, -> { where("status <> ?", Passenger.statuses[:going]) }
end
