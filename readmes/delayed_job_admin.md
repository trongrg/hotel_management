# Delayed Job Admin README

Delayed Job Admin console is available at [/delayed_job_admin](http://localhost:3000/delayed_job_admin).

```
open http://localhost:3000/delayed_job_admin
```

## Steps to complete

### Authentication

By default, there is no authentication or authorization protecting access to `/delayed_job_admin`.

Please go to `app/controllers/application_controller.rb` and edit the following method:

```ruby
def delayed_job_admin_authentication
  # authentication_logic_goes_here
  true
end
```

For example, if you are using the Devise gem and have an Admin model:

```ruby
def delayed_job_admin_authentication
  authenticate_admin!
end
```

