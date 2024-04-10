class Alarm < ApplicationRecord
  attribute :triggered, :boolean, default: false
end
