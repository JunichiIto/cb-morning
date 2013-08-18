desc "Import menu items"
task :import_menu_items, [] => :environment do |t, args|
  puts "start"
  MenuItem.transaction do
    File.open("./menu_text/edited_menu_items.tsv", "r").each_line do |line|
      category, menu_item = line.split("\t")
      puts "Createging #{category}/#{menu_item}"
      MenuItem.create! name: menu_item, category_list: category
    end
  end
  puts "end"
end
