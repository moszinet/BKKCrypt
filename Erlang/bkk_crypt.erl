% BKK secure chiper module %

% Usage, from erl:
%% c(bkk_crypt).
%% bkk_crypt:encrypt("Haxxor protec, but he also attac").
-module(bkk_crypt).
-export([encrypt/1]).

encrypt(Message) ->
    Message.
