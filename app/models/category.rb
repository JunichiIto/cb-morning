class Category < ActiveRecord::Base
  has_many :menu_items
  validates_presence_of :name
  acts_as_list
  default_scope order: :position
end
