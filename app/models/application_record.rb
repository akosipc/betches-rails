require 'validators/past_date_validator'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
