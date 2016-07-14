# == Schema Information
#
# Table name: maps
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  rows       :integer          not null
#  cols       :integer          not null
#  time       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
