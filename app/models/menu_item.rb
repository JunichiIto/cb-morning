class MenuItem
  include FirerecordKakkoKari

  attr_accessor :category

  attribute :id, :string
  attribute :created_at, :time
  attribute :updated_at, :time

  attribute :category_id, :string
  attribute :name, :string

  validates :category_id, presence: true
  validates :name, presence: true

  class << self
    def with_category(category)
      records = col.where(:category_id, :==, category.id).get.map do |data|
        to_instance(data).tap { |mi| mi.category = category }
      end
      records.sort_by(&:created_at).reverse
    end

    # Override
    def find(id)
      record = super
      record.category = Category.find(record.category_id)
      record
    end

    private

    # Override
    def collection_name
      'menu_item'.freeze
    end

    # Override
    def to_instance(data)
      new(
        id: data.document_id,
        created_at: data.created_at,
        updated_at: data.updated_at,

        category_id: data[:category_id],
        name: data[:name],
        keyword_list: data[:keyword_list],
      )
    end
  end

  def save_with_tags
    if save
      Tag.save_tags(keyword_list)
      true
    else
      false
    end
  end

  def update_with_tags(params)
    if update(params)
      Tag.save_tags(keyword_list)
      true
    else
      false
    end
  end

  def keyword_list
    @keyword_list ||= []
  end

  def keyword_list=(list)
    @keyword_list = list
  end

  def keyword_list_text
    keyword_list.sort.join(",")
  end

  def keyword_list_text=(text)
    keywords = text.to_s.split(',').map(&:strip).uniq.sort
    keyword_list.clear
    keywords.each do |keyword|
      keyword_list << keyword
    end
  end

  private

  # Override
  def save_params
    {
      name:,
      category_id:,
      keyword_list:,
    }
  end
end
