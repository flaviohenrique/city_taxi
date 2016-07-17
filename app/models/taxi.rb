# == Schema Information
#
# Table name: taxis
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  passenger_id :integer
#  status       :integer          not null
#  row          :integer          not null
#  col          :integer          not null
#  map_id       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Taxi < ActiveRecord::Base
  has_one :passenger, autosave: true
  belongs_to :map

  enum status: [:empty, :going, :full]
end
