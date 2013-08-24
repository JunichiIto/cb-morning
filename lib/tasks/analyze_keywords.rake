desc "Analyze keywords in menu item names / ex: rake 'analyze_keywords[xxx]'"
task :analyze_keywords, [:app_key] => :environment do |t, args|
  YahooJA.configure{|c| c.app_key = args.app_key}
  MenuItem.joins(:category).where(categories: {name: %w(菓子パン おかずパン)}).each do |menu_item|
    name = menu_item.name.strip
    cols = [menu_item.id, name]
    result = YahooJA.morpheme_analysis name,{:results => "ma"}
    result.each do |k, v|
      words = v[:word_list][:word]
      if words.is_a? Hash
        words = [words]
      end
      words.each do |word|
        if !%w(助詞 特殊).include?(word[:pos]) and word[:reading] != 'ぱん'
          cols << word[:surface]
        end
      end
    end
    puts cols.join("\t")
  end
end
