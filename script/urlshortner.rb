require 'launchy'

class ConsoleInterface
  def initialize
    login
    menu
  end
  def login
    puts "Wecome to the **AMAZING URL Shortner** by David and Bryant"
    puts "Enter email address?"
    email = gets.chomp
    record = User.find_by_email(email)
    if record.nil?
      puts "Please select a username"
      username = gets.chomp
      @current_user = User.create(email: email, username: username)
    else
      puts "Logging in as #{record.username}"
      @current_user = record
    end
  end
  def menu
    puts "What would you like to do?"
    puts "Commands: 1) Submit Link \n 2) Browse Links \n 3) Popular sites by tag"
    puts " 4) User history \n 5) Login as another user \n 6) Exit"
    case gets.chomp.to_i
    when 1 then shorten_link
    when 2 then display_links
    when 3 then popular_sites
    when 4 then user_history
    when 5 then login
    when 6 then return nil
    end
    menu
  end

  def user_history
    puts "Links: #{@current_user.links}"
    puts "Visits: #{@current_user.visits}"
    puts "Comments: #{@current_user.comments}"
  end

  def shorten_link
    puts "What link would you like to shorten?"
    link = gets.chomp
    short_link = @current_user.shorten_link(link)
    while true
      puts "Enter tag name or 'e' for exit"
      tag = gets.chomp
      break if tag == 'e'
      Tag.tag_link(short_link, tag)
    end
  end

  def display_links
    urls = Link.all.map { |link| link.shortened_link }
    puts urls
    puts "Choose a url to visit"
    choice = gets.chomp
    if urls.include?(choice)
      link = Link.find_by_shortened_link(choice)
      url = LongURL.find(link.long_url_id).url
      display_comments(link)
      Launchy.open(url)
      Visit.record_visit(@current_user, link)
    else
      puts "Invalid URL!!!!11111"
    end
  end

  def display_comments(link)
    link.comments.map { |comment| puts "#{comment.created_at}: #{comment.body}" }
    puts "Add a comment? 'e' to exit"
    body = gets.chomp
    return if body == 'e'

    Comment.add(@current_user, link, body)
  end

  def popular_sites
    existing_tags = TagType.all.map { |tag| tag.tag_name }
    p existing_tags
    puts "Choose the tag you would like to view popular sites for:"
    tag = gets.chomp
    if existing_tags.include?(tag)
      puts Link.most_popular(tag).shortened_link
    else
      puts "No tags of this type."
    end

  end

end
interface = ConsoleInterface.new