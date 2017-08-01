%%% BKK secure cipher module %

%% Usage, from erl...
%%
%% - compile:
%%
%%     > c(bkk_crypt).
%%
%% - run:
%%
%%     > bkk_crypt:encrypt("Haxxor protec, but he also attac").
%%
%% - to run tests:
%%
%%     > eunit:test(bkk_crypt).
%%
-module(bkk_crypt).

%% API
-export([encrypt/1]).

%% Tests
-include_lib("eunit/include/eunit.hrl").

encrypt(Message) ->
    Message.

-ifdef(EUNIT).
encrypt_test() ->
    ?assertEqual("password", bkk_crypt:encrypt("password")),
    ?assertNotEqual("7KVcbLRkKU15XiCRlTGuj0raudw+pl+SaGVnm456LoE=", bkk_crypt:encrypt("password")).
-endif.
