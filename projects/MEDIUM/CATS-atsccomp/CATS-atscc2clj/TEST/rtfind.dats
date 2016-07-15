(* ****** ****** *)
//
// HX-2016-07:
// A running example
// from ATS2 to Clojure
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2CLJ}/staloadall.hats"
//
(* ****** ****** *)
//
extern
fun
rtfind (f: int -> int): int = "mac#"
//
implement
rtfind (f) = let
//
fun loop
(
  f: int -> int, i: int
) : int =
  if f (i) = 0 then i else loop (f, i+1)
//
in
  loop (f, 0(*i*))
end // end of [rtfind]

(* ****** ****** *)

extern 
fun
main0_ats
(
// argumentless
) : void = "mac#rtfind_main0_ats"
//
implement
main0_ats () =
{
//
val
poly0 = lam(x:int): int => x*x + x - 6
//
val () =
println! ("rtfind(lambda x: x*x + x - 6) = ", rtfind(poly0))
//
} (* end of [main0_ats] *)

(* ****** ****** *)

%{$
;;
(rtfind_main0_ats)
;;
%} // end of [%{]

(* ****** ****** *)

(* end of [rtfind.dats] *)
