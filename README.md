# HTTP, Yeah You Know Me

__Running the Test Files__

First, start the server with `ruby lib/runner.rb`

Once the server has been started, the tests should be run in the following order:

* `game_test`
* `server_test`
* `response_test`
* `headers_test`
* `parse_request_test`
* `word_search_test`
* `shutdown_test`

If, after running the first test, you receive an error that states:
  "/http/lib/response.rb:61:in `get_game': undefined method `game_info' for nil:NilClass (NoMethodError)"
restart your server and run the tests again. You may need to repeat this several times.

The final test should close your server.
