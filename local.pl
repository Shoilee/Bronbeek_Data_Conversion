:- use_module(library(semweb/rdf_library)).
:- use_module(library(semweb/rdf_db)).

:- set_prolog_flag(stack_limit, 2_147_483_648) .

load_bronbeek :-
    rdf_attach_library('RDF/void.ttl'),
    rdf_load('RDF/void.ttl', [graph('https://pm.labs.vu.nl/void')]),
    rdf_library:rdf_load_library('bronbeek-enriched'),
    rdf_library:rdf_load_library('bronbeek').

% :- load_bronbeek.

