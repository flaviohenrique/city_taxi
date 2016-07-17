require 'csv'

class CityMap::FileReader
  
  BLOCK_VALUE = 'x'

  def read(file, map)
    row_number = 0

    CSV.foreach(file.tempfile) do |row|
      map.cols ||= row.size

      row.each_with_index do |value, col|
        map.blocks.build(row: row_number, col: col) if value == BLOCK_VALUE
      end
      row_number += 1
    end

    map.rows = row_number
    map
  end
end
