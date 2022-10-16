# rails runner scripts/migrate_to_firestore.rb
require 'csv'
csv_path = Rails.root.join("doc/seeds/data-2022-10-15.csv")

# 古いレコードを削除
MenuItem.destroy_all
Category.destroy_all
Tag.destroy_all

# カテゴリを登録
puts "Save categories..."
categories = {}
position = 1
CSV.foreach(csv_path, headers: true) do |row|
  name = row['category_name']
  unless categories[name]
    category = Category.create!(name: , position: )
    categories[name] = category
    position += 1
  end
end

# MenuItemを登録
puts "Save menu_items..."
CSV.foreach(csv_path, headers: true) do |row|
  category_name = row['category_name']
  category = categories[category_name]
  category_id = category.id
  name = row['menu_item_name']
  keyword_list_text = row['tag_name']
  MenuItem.create!(name: , keyword_list_text: , category_id: )
end

# Tagを登録
puts "Save tags..."
keywords = []
CSV.foreach(csv_path, headers: true) do |row|
  keyword_list_text = row['tag_name']
  menu_item = MenuItem.new(keyword_list_text: )
  keywords += menu_item.keyword_list
end
keywords.uniq.sort_by { |r| r.hiragana }.each do |name|
  Tag.create!(name: )
end
