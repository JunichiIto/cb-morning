desc "Fetch menu feeds from Facebook page / ex: rake 'fetch_menu_feeds[xxx,20]'"
task :fetch_menu_feeds, [:access_token, :limit] => :environment do |t, args|
  page = first_page(args.access_token, args.limit)

  messages = page.map{|feed| feed['message']}.select{|message| message =~ /本日\([\/\d]+\)のメニュー/}

  messages.each do |message|
    puts message
    puts "\n=================\n"
  end

  puts "Count: #{messages.size}"
end

def first_page(access_token, limit)
  # https://github.com/arsduo/koala/wiki/Acting-as-a-Page
  @user_graph = Koala::Facebook::API.new(access_token)
  pages = @user_graph.get_connections('me', 'accounts')
  first_page_token = pages[1]['access_token'] # Would be Coupe Baguette
  @page_graph = Koala::Facebook::API.new first_page_token
  @page_graph.get_connection('me', 'feed', limit: limit)
end
