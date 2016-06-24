(*
##
## ATS-extsolve-smt2:
## Outputing ATS-constraints
## in the format of smt-lib2
##
*)

(* ****** ****** *)
//
#ifndef
PATSOLVE_SMT2_SOLVING
#include "./myheader.hats"
#endif // end of [ifndef]
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

local

typedef
key = string and itm = int

in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)

local
//
val
the_s2cinterp_map =
  myhashtbl_make_nil(1024)
//
fun
s2cinterp_insert(name: string): void =
{
//
val-~None_vt() =
  myhashtbl_insert(the_s2cinterp_map, name, 0)
// end of [val]
} (* end of [s2cinterp_insert] *)
//
in (* in-of-local *)
//
implement
s2cst_get_s2cinterp
  (s2c) = let
//
val ptr =
  s2cst_get_payload(s2c)
//
in
//
if
ptr > 0
then $UN.cast{s2cstopt}(ptr)
else let
//
val key = symbol_get_name(s2c.name())
val opt = myhashtbl_search(the_s2cinterp_map, key)
val itm =
(
  case+ opt of
  | ~None_vt _ => None() | ~Some_vt _ => Some(s2c)
) : s2cstopt // end of [val]
val () = s2cst_set_payload(s2c, $UN.cast{ptr}(itm))
//
in
  itm
end // end of [else]
//
end // end of [s2cst_get_s2cinterp]
//
implement
the_s2cinterp_initize() =
{
//
macdef
insert = s2cinterp_insert
//
val () = insert("null_addr")
//
val () = insert("true_bool")
val () = insert("false_bool")
//
val () = insert("neg_int")
val () = insert("abs_int")
val () = insert("sgn_int")
//
val () = insert("add_int_int")
val () = insert("sub_int_int")
val () = insert("mul_int_int")
val () = insert("div_int_int")
val () = insert("mod_int_int")
//
val () = insert("idiv_int_int")
val () = insert("ndiv_int_int")
//
val () = insert("eq_int_int")
val () = insert("lt_int_int")
val () = insert("gt_int_int")
val () = insert("lte_int_int")
val () = insert("gte_int_int")
val () = insert("neq_int_int")
//
val () = insert("max_int_int")
val () = insert("min_int_int")
//
val () = insert("neg_bool")
//
val () = insert("add_bool_bool")
val () = insert("mul_bool_bool")
//
val () = insert("eq_bool_bool")
val () = insert("lt_bool_bool")
val () = insert("gt_bool_bool")
val () = insert("lte_bool_bool")
val () = insert("gte_bool_bool")
val () = insert("neq_bool_bool")
//
} (* end of [the_s2cinterp_initize] *)

end // end of [local]

(* ****** ****** *)

(* end of [patsolve_smt2_solving_interp.dats] *)
