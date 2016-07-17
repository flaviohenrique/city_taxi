# == Schema Information
#
# Table name: map_blocks
#
#  id         :integer          not null, primary key
#  row        :integer          not null
#  col        :integer          not null
#  map_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MapBlock < ActiveRecord::Base
  belongs_to :map

  def position=(position)
    self.row = position.row
    self.col = position.col
  end

  def position
    Position.new(row, col)
  end  
end
