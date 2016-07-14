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

require 'test_helper'

class MapBlockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
