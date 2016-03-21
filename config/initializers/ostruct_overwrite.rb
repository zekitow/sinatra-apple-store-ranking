require 'ostruct'

#
# Removes the "table" attribute
# created while OpenStruct "to_json" is called.
#
class OpenStruct
  def as_json(options = nil)
    @table.as_json(options)
  end
end
