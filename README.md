# VCERB prototype

This project explores a way to conveniently render [View Components](https://viewcomponent.org) using
a custom ActionView template handler.

## What is VCERB?

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

## Running the example

Bundle, rails server, open localhost:3000.
