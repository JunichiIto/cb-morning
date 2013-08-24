class MenuItem < ActiveRecord::Base
  acts_as_taggable_on :categories
  belongs_to :category
end
