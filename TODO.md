# CHANGES
- added minimal RDoc documentation
- RDoc will be generated with with `rake rdoc` or when installing the gem
- test installation via bundler and :git

# TODO
- externalize the env= URL parameter and allow the use of other customer YQL tables that are not part of the YQL community tables (they can already be used in the YQL query itself but not via an URL parameter)
- enable switching SSL on/off
- should the top level wrapper of YqlSimple be a class or a module?
- handle YQL status codes (which indicate errors)
- write some tests for YQL exceptions
- currently the ./examples folder is added to the gem. not really good. how to exclude it?

