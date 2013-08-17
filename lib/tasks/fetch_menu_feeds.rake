desc "Fetch menu feeds from Facebook page / ex: rake 'fetch_menu_feeds[xxx]'"
task :fetch_menu_feeds, [:access_token] => :environment do |t, args|
  puts "start\n"

  # https://github.com/arsduo/koala/wiki/Acting-as-a-Page
  @user_graph = Koala::Facebook::API.new(args.access_token)
  pages = @user_graph.get_connections('me', 'accounts')
  first_page_token = pages.first['access_token'] # Would be Coupe Baguette
  @page_graph = Koala::Facebook::API.new first_page_token
  wall = @page_graph.get_connection('me', 'feed')

  wall.each do |feed|
    message = feed['message']
    if message =~ /本日.+メニュー/
      puts message
      puts "\n==================\n"
    end
  end

  puts "\nend"
end
