class MenuItem < ActiveRecord::Base
  acts_as_taggable_on :keywords
  belongs_to :category
end
