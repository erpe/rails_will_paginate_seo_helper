# rails_will_paginate_seo_helper

This is standing on the shoulder of a giant: :heart: https://github.com/mislav/will_paginate
and adds some seo-sugar on top.

A simple Rails ViewHelper to display link-tags for will_paginate in header.


Url-Parameter left untouched.

Atm. expects 'page' as page_param -key.

Google suggests to add rel=next and rel=prev link-tags on paged pages: https://webmasters.googleblog.com/2011/09/pagination-with-relnext-and-relprev.html

If you want to have seo link-tags for pages in your rails app without monkey patching will_paginate:

## Setup
simple add to your Gemfile:

```ruby
 # works with rails 4 and 5
 gem 'will_paginate'
 gem 'rails_will_paginate_seo_helper'
```
## Usage

 a will_paginate paged ActiveRecord::Relation
 from your controller:
 
 ```ruby
 @todos = Todo.all.paginate(page: params[:page])
 ```
now you can use on your templates (expects ```<%= yield :pagination_rel_links %>``` in your layout)

```html
 <!-- in todos/index.html.erb -->
 <% content_for :pagination_rel_links do %>
  <%= will_paginate_seo_links(@todos) %>
 <% end %>
```


given we are on page 2 - output will be:
```html
<link href="http://localhost:3000/todos" rel="prev">
<link href="http://localhost:3000/todos?page=3" rel="next">
```
