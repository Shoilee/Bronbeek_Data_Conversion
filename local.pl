:- use_module(library(semweb/rdf_library)).
:- set_prolog_flag(stack_limit, 2_147_483_648) .

load_bronbeek :-
    rdf_attach_library('RDF/void.ttl'),
    rdf_library:rdf_load_library('bronbeek-enriched'),
    rdf_library:rdf_load_library('bronbeek').

:- load_bronbeek.

