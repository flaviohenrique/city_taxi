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

require 'test_helper'

class PassengerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
