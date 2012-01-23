module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^the home\s?page$/
      "/"
    when /^the sign in page$/
      "/sign_in"
    when /^the profile page$/
      "/profile"
    when /^the (.+) page of (.+)$/
      path_components = $1.split(" ").push("path")
      model_objects = $2.split(", ")
      objects = model_objects.map do |model_object|
        model, object_name = model_object.split("\"").map { |e| e.gsub("\"", "").strip }
        find_method = case model
                      when 'user'
                        'find_by_username'
                      when 'hotel'
                        'find_by_name'
                      end
        model.titleize.constantize.send(find_method, object_name)
      end
      self.send(path_components.join("_").to_sym, *objects)
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
