# rails runner scripts/migrate_to_firestore.rb
require 'csv'
csv_path = Rails.root.join("doc/seeds/data-2022-10-15.csv")

# 古いレコードを削除
MenuItem.destroy_all
Category.destroy_all
Tag.destroy_all

# カテゴリを登録
categories = {}
position = 1
CSV.foreach(csv_path, headers: true) do |row|
  name = row['category_name']
  unless categories[name]
    category = Category.new(name: , position: )
    category.save!
    categories[name] = category
    position += 1
  end
end

# MenuItemを登録
CSV.foreach(csv_path, headers: true) do |row|
  category_name = row['category_name']
  category = categories[category_name]
  category_id = category.id
  name = row['menu_item_name']
  keyword_list_text = row['tag_name']
  unless categories[name]
    menu_item = MenuItem.new(name: , keyword_list_text: , category_id: )
    menu_item.save_with_tags
  end
end
