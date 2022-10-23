class Category
  include ActAsFireRecordBeta

  firestore_attribute :name, :string
  firestore_attribute :position, :integer

  validates :name, presence: true
  validates :position, presence: true

  class << self
    # Override
    def all
      order(:position).get_records
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
