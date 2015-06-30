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

## Wrapping chef-alfresco

Imagine that you want to write your `own-chef-alfresco` cookbook that wraps `chef-alfresco` features, overriding some derived attributes, such as
```
node.set['alfresco']['properties']['dir.root.contentstore'] = #{node['alfresco']['properties']['dir.root']}/myowncontentstore`
```

Below the steps to perform:

1. Identify which `_*-attributes.rb` file in chef-alfresco defines `node['alfresco']['properties']['dir.root']`, which is `alfresco::_common-attributes.rb`
2. Create a Chef recipe that includes the recipe found in step #1 (i.e `recipes/default.rb`)
3. Set the attribute values (using node.default, node.set or node.override, depending on `alfresco::_common-attributes.rb` logic) that you want to define/overwrite
4. Call chef-alfresco default recipe

Here's the Chef code of `recipes/default.rb`
```
include_recipe "alfresco::_common-attributes.rb"
node.default['alfresco']['proprties']['dir.root.contentstore'] = #{node['alfresco']['proprties']['dir.root']}/myowncontentstore`
include_recipe "alfresco::default"
```

### Default attributes warning

It is very important to note that not all chef-alfresco default attributes cannot be overridden by the default attributes of a wrapping cookbook(!)

Imagine the requirements described above; you could define `attributes/default.rb` as follows:
```
default['alfresco']['properties']['dir.root.contentstore'] = "#{node['alfresco']['properties']['dir.root']}/myowncontentstore"
```

This code won't work, for 2 reasons:

1. The default attribute value declaration (of `default['alfresco']['properties']['dir.root.contentstore']`) would be overridden by `alfresco::_common-attributes.rb`
2. The attribute value of `node['alfresco']['properties']['dir.root']` is not set yet; only `attributes/*.rb` attributes can be used here
