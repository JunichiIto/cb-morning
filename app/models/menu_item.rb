class MenuItem
  include FireRecordKakkoKari

  attr_accessor :category

  attribute :category_id, :string
  attribute :name, :string
  firestore_attributes :category_id, :name, :keyword_list

  validates :category_id, presence: true
  validates :name, presence: true

  class << self
    def with_category(category)
      records = search(where: [:category_id, :==, category.id]) do |record|
        record.category = category
      end
      sort(records)
    end

    def tagged_with(name)
      records = search(where: [:keyword_list, :array_contains, name])
      sort(records)
    end

    # Override
    def find(id)
      record = super
      record.category = Category.find(record.category_id)
      record
    end

    def sort(records)
      records.sort_by { |r| r.name.hiragana }
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
end
