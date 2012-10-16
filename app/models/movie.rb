class Movie < ActiveRecord::Base
  attr_accessible :string
  scope :named, lambda {|q|
    where('title ilike ?', "#{q}%")
  }
end
