class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_all_by(params)
    where(params)
  end
end
