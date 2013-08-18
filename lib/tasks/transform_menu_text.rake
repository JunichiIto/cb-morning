desc "Transform menu_history_text"
task :transform_menu_text, [] => :environment do |t, args|
  category = ""
  category_line = ""
  menu_table = {}
  File.open("./menu_text/menu_history.txt", "r").each_line do |line|
    line.strip!
    if line =~ /\[(.+)\]/ or line =~ /◎(.+)/
      category = $1
      category_line = line
      menu_table[category] = [] unless menu_table.has_key?(category)
    end
    if line.present? and line != category_line and !(line =~ /Count|^=+$/) and !(line =~ /ます|です|でした|まーす|でーす|ました|ください|どうぞ|お取り置き/)
      menu_items = menu_table[category]
      menu_items << line unless menu_items.include?(line)
    end
  end

  menu_table.each do |category, menu_items|
    menu_items.each do |item|
      puts "#{category}\t#{item}"
    end
  end
end
