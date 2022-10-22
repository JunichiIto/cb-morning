class Tag
  include ActAsFireRecordBeta

  attribute :name, :string
  firestore_attributes :name

  validates :name, presence: true

  class << self
    # Override
    def all
      records = super
      records.sort_by { |r| r.name.hiragana }
    end

    def save_tags(names)
      names.each do |name|
        unless find_by(name:)
          create!(name: )
        end
      end
    end
  end
end
