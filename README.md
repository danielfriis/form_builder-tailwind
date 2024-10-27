# FormBuilder Tailwind

Easily add Tailwind styles to your forms using the `FormBuilder::Tailwind` builder.

## Usage

```erb
<%= form_with model: @user, builder: FormBuilder::Tailwind do |f| %>
  <%= f.text_field :name %>
<% end %>
```

To hide the label for a form field, you can use the `hide_label: true` option. Here is an example:

```erb
<%= form_with model: @user do |f| %>
  <%= f.text_field :name, hide_label: true %>
<% end %>
```

## Development

### Release

Prepare for release:

```sh
git add .
git commit -m "Prepare for release vX.X.X"
git push origin HEAD
git tag vX.X.X
git push --tags
```

Build and push gem:

```sh
gem build form_builder-tailwind.gemspec
gem push form_builder-tailwind-X.X.X.gem
```
