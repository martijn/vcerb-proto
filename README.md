# VCERB prototype

This project explores a way to conveniently render [View Components](https://viewcomponent.org) using
Va custom ActionView template handler.

When successful, this will be rewritten as a gem to include in a Rails app.

## What is VCERB?

VCERB syntax allows developers to instiate View Components using HTML tags,
not unlike React or Blazor.

Example:

```erbruby
<!-- VCERB syntax -->

<Notification title="my title">
  Hello, world
</Notification>

<!-- Standard ViewComponent syntax -->

<%= render(NotificationComponent.new(title: "my title")) do %>
  Hello, World!
<% end %>
```

To include literal Ruby in params:

```erbruby
<Notification title={@title.upcase} />
```

## Running the example

Bundle, rails server, open localhost:3000.

## Notable files in the example

- [app/views/page/index.html.vcerb](app/views/page/index.html.vcerb) a demo vcerb view
- [lib/vcerb.rb](lib/vcerb.rb) the template handler
- [config/initializers/vcerb.rb](config/initializers/vcerb.rb) an initializer that registers the template handler
