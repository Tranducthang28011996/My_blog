class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_accessor :search

end
