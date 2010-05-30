class MapArrangement < ActiveRecord::Base
  belongs_to :user
  has_many :map_arrangement_pieces
end