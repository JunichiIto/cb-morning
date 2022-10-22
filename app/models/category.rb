class Category
  include ActAsFireRecordBeta

  attribute :name, :string
  attribute :position, :integer
  firestore_attributes :name, :position

  validates :name, presence: true
  validates :position, presence: true

  class << self
    # Override
    def all
      order(:position).find_many
    end
  end

  def menu_items
    MenuItem.with_category(self)
  end

  def destroy_with_menu_items
    destroy
    MenuItem.where(:category_id, :==, id).destroy_all
  end
end
