desc "Import menu_history_text"
task :import_history_text, [] => :environment do |t, args|
  category = ""
  category_line = ""
  File.open("menu_history.txt", "r").each_line do |line|
    if line =~ /\[(.+)\]/ or line =~ /◎(.+)/
      category = $1
      category_line = line
      puts category
    end
    if line != category_line and !(line =~ /Count|^=+$/) and !(line =~ /ます|です|でした|まーす|でーす|ました|ください|どうぞ/)
      puts line
    end
  end
end
