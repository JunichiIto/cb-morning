class Category
  include FirerecordKakkoKari

  attribute :id, :string
  attribute :created_at, :time
  attribute :updated_at, :time

  attribute :name, :string
  attribute :position, :integer

  validates :name, presence: true
  validates :position, presence: true

  class << self
    def all
      col.order(:position).get.map do |data|
        to_instance(data)
      end
    end

    private

    # Override
    def collection_name
      'category'.freeze
    end

    # Override
    def to_instance(data)
      new(
        id: data.document_id,
        name: data[:name],
        position: data[:position],
        created_at: data.created_at,
        updated_at: data.updated_at
      )
    end
  end

  private

  # Override
  def save_params
    {
      name:,
      position:,
    }
  end
end
