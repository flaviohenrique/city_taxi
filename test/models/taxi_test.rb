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

require 'test_helper'

class TaxiTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
