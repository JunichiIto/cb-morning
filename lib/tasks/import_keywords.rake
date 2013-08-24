desc "Import keywords"
task :import_keywords, [] => :environment do |t, args|
  puts "start"
  MenuItem.transaction do
    File.open("./menu_text/edited_keywords.tsv", "r").each_line do |line|
      line.strip!
      id, name, *keywords = line.split("\t")
      puts "#{id} / #{name} / #{keywords}"
      menu_item = MenuItem.find id
      menu_item.keyword_list = keywords.join(",")
      menu_item.save!
    end
  end
  puts "end"
end

