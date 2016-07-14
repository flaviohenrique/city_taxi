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

class Map < ActiveRecord::Base
  has_many :blocks , class_name: 'MapBlock'
  has_many :taxis
  has_many :passengers
end
