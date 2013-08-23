class Category < ActiveRecord::Base
  has_many :menu_items, order: "position"
  validates_presence_of :name
end
