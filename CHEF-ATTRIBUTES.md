# Chef Attributes guidelines

Why defining Chef Attribute guidelines?

1. Readability; easily identify the right attribute or recipe file, find the right default property value and understand how to override it
2. Extensibility; easily override/overwrite attibute values from Chef JSON attributes, Chef wrapping cookbook defaults and recipes (see "Wrapping cookbook extensibility issues" below)
3. Simplicity; Chef has many ways to define attributes, so it must be clear how to interact with chef-alfresco

Guidelines:

1. Use `attributes/*.rb` for static attribute value definitions
2. Use `recipes/_*-attributes.rb` for derived attribute value definitions (or static ones that whose default values are not conditional)
3. Use `attributes/_common-attributes.rb` to define derived attributes that are needed also by other `_*-attributes.rb` files
4. Never setup a node.default twice from different recipes
5. Avoid using node.set and node.override within chef-alfresco
6. Don't define `default['something'] = "#{node['something_else']}/more" (or similar, unless Ohai-based) in ```attributes/*.rb```

## Wrapping cookbook extensibility issues

Imagine that chef-alfresco defines a `attributes/test.rb` with
```
default['something'] = "much"
default['something_else'] = "#{node['something']}/more"
```

This would imply that I can:

1. Create `my-own-chef-alfresco`
2. Define `attributes/default.rb` with `default['something'] = "much/much"`
3. Define `recipes/default.rb` with `include_recipe "alfresco::default"`
4. Expect that `node['something_else']` is `much/much/more`

This is not guaranteed by Chef (test this again!!!) and is the reason for the guidelines above.

The right (and safe) way to override a derived attribute is to do it in a recipe (i.e. `recipes/default.rb`) , using `node.*['']` method:
```
include_recipe "alfresco::_test-attributes.rb"
include_recipe "alfresco::default"
```
