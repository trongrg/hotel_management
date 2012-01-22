module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^the home\s?page$/
      "/"
    when /^the sign in page$/
      "/sign_in"
    when /^the profile page$/
      "/profile"
    when /^the (.+) page of "([^"]+)"$/
      path_components = $1.split(" ")
      model = path_components.last.singularize
      keyword = $2
      find_method = case model
                    when 'user'
                      'find_by_username'
                    end
      object = model.humanize.constantize.send(find_method, keyword)
      self.send(path_components.push('path').join('_').to_sym, object)
    else
      begin
        page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
