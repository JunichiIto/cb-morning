class Category
  include FireRecordKakkoKari

  attribute :name, :string
  attribute :position, :integer
  firestore_attributes :name, :position

  validates :name, presence: true
  validates :position, presence: true

  class << self
    # Override
    def all
      super(order: :position)
    end
  end

  def menu_items
    MenuItem.with_category(self)
  end
end
