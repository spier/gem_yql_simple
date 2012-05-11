- implement OAuth with YQL (will give the user more calls to YQL)
- how to test the validity of the OAuth parameters?

- add more test
- write some tests for YQL exceptions

- make the desired node in the YQL response selectable e.g. query/results/item

- how to properly raise exceptions?
	https://github.com/outsidein/api-rb/blob/master/lib/outside_in/resource/base.rb#L46	

- get a YQL application key here
	https://developer.apps.yahoo.com/projects

- externalize the env= URL parameter and allow the use of other customer YQL tables that are not part of the YQL community tables (they can already be used in the YQL query itself but not via an URL parameter)
- enable switching SSL on/off
- should the top level wrapper of YqlSimple be a class or a module?
- handle YQL status codes (which indicate errors)

- currently the ./examples folder is added to the gem. not really good. how to exclude it?

# Future
- add [YQL Streaming](http://developer.yahoo.com/yql/guide/yql-odt-streaming.html) 