%% @author Arjan Scherpenisse <arjan@scherpenisse.net>

-module(z_html_test).

-include_lib("eunit/include/eunit.hrl").


link_elements_test() ->
    ?assertEqual([[{"rel", "foo"}]], z_html:scrape_link_elements("<p>This is text.<link rel=\"foo\" /></p>")),
    ?assertEqual([[{"rel", "Foo"}]], z_html:scrape_link_elements("<p>This is text.<LINK REL=\"Foo\" /></p>")),
    ok.


escape_props_test() ->
    ?assertEqual([{title, <<"Foo &amp; bar">>}],
                 z_html:escape_props([{title, <<"Foo & bar">>}])),

    ?assertEqual([{body, <<"Foo &amp; bar">>}],
                 z_html:escape_props([{body, <<"Foo & bar">>}])),
    ok.

ensure_check_test() ->
	?assertEqual(<<"&#1234; &lt;&gt;;">>, z_html:escape_check(<<"&#1234; <>;">>)),
	ok.

strip_test() ->
	?assertEqual(<<"Hello">>, z_html:strip(<<"<p class='hello'>Hello</p>">>)),
	ok.

abs_links_test() ->
    ?assertEqual(
        <<"Hello <a src=\"http://example.com/a/b/c.html\">">>, 
        z_html:abs_links(<<"Hello <a src=\"c.html\">">>, 
                         <<"http://example.com/a/b/d.html">>)),
    ?assertEqual(
        <<"Hello <a src=\"http://example.com/c.html\">">>, 
        z_html:abs_links(<<"Hello <a src=\"/c.html\">">>, 
                         <<"http://example.com/a/b/d.html">>)),
    ?assertEqual(
        <<"Hello <a src=\"http://b.org/c.html\">">>, 
        z_html:abs_links(<<"Hello <a src=\"http://b.org/c.html\">">>, 
                         <<"http://example.com/a/b/d.html">>)),
    ok.
