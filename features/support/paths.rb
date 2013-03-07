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
      path = to_path($1)
      models = $2.scan(/([^",]+)"([^",]+)"/).flatten.map(&:strip)
      models = Hash[*models]
      path_of(path, models)
    when /^the (.+) page with invitation token of user "(.+)"$/
      invitation_path($1, $2)
    when /the (.+) page$/
      default_path($1)
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  rescue NoMethodError, ArgumentError
    raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      "Now, go and add a mapping in #{__FILE__}"
  end

  private
  def default_path(page_name)
    path = to_path(page_name)
    self.send(path)
  end

  def path_of(path, models)
    objects = models.map do |model, object_name|
      begin
        modulize(model).send(find_method_for(model), object_name)
      rescue NameError
        { model.to_sym => object_name }
      end
    end
    self.send(path, *objects)
  end

  def invitation_path(page, email)
    path = to_path(page)
    invitation_token = User.find_by_email(email).invitation_token
    send(path, :invitation_token => invitation_token)
  end

  def modulize(model_name)
    model_name.parameterize.underscore.camelize.constantize
  end

  def to_path(page_name)
    "#{page_name.parameterize.underscore}_path"
  end
end

World(NavigationHelpers)
