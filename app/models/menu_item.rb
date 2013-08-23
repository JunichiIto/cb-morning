class MenuItem < ActiveRecord::Base
  acts_as_taggable_on :categories
  belongs_to :category
  acts_as_list scope: :category
end
