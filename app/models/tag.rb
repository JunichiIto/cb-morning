class Tag
  include FirerecordKakkoKari

  attribute :id, :string
  attribute :created_at, :time
  attribute :updated_at, :time

  attribute :name, :string

  validates :name, presence: true

  class << self
    def all
      records = col.order(:name).get.map do |data|
        to_instance(data)
      end
      records.sort_by { |r| r.name.hiragana }
    end

    def save_tags(names)
      names.each do |name|
        unless find_by(name:)
          record = new(name:)
          record.save!
        end
      end
    end

    private

    # Override
    def collection_name
      'tag'.freeze
    end

    # Override
    def to_instance(data)
      new(
        id: data.document_id,
        created_at: data.created_at,
        updated_at: data.updated_at,

        name: data[:name],
        )
    end
  end

  private

  # Override
  def save_params
    {
      name:,
    }
  end
end
