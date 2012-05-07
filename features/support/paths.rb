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
        begin
          model.titleize.gsub(' ', '').constantize.send(find_method_for(model), object_name)
        rescue NameError
          {model.to_sym => object_name}
        end
      end
      self.send(path_components.join("_").to_sym, *objects)
    when /^the (.+) page with invitation token of user "(.+)"$/
      path_components = $1.split(" ").push("path")
      invitation_token = User.find_by_email($2).invitation_token
      send(path_components.join("_"), :invitation_token => invitation_token)
    when /^the (.+) page with (.+)$/
      path_components = $1.split(" ").push("path")
      query_string = $2.split(", ")
      query_string = query_string.map do |query|
        key, value = query.split("\"").map { |e| e.gsub("\"", "").strip }
        Hash[key.gsub(" ", "_").to_sym => value]
      end
      self.send(path_components.join("_").to_sym, *query_string)
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
