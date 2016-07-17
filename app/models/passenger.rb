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

  def position=(position)
    self.row = position.row
    self.col = position.col
  end

  def position
    Position.new(row, col)
  end

  def dest_position=(position)
    self.dest_row = position.row
    self.dest_col = position.col
  end

  def dest_position
    Position.new(dest_row, dest_col)
  end

end
