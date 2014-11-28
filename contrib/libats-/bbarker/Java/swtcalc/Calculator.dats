(*
** Implementation of
** a simple calculator in ATS for use in Java
*)

(* ****** ****** *)
//
// no run-time dynloading
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
staload
CALC = "./../../../../../projects/SMALL/Calculator/calculator.sats"
//
(* ****** ****** *)

local
//
#include "./../../../../../projects/SMALL/Calculator/calculator_aexp.dats"
#include "./../../../../../projects/SMALL/Calculator/calculator_token.dats"
#include "./../../../../../projects/SMALL/Calculator/calculator_cstream.dats"
#include "./../../../../../projects/SMALL/Calculator/calculator_tstream.dats"
#include "./../../../../../projects/SMALL/Calculator/calculator_parsing.dats"
#include "./../../../../../projects/SMALL/Calculator/calculator_print.dats"
#include "./../../../../../projects/SMALL/Calculator/calculator_mylib.dats"
//
in (*nothing*) end

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload JNI = "{$JNI}/SATS/jni.sats"

(* ****** ****** *)

stadef JNIEnvPtr = $JNI.JNIEnvPtr
stadef jstring (l:addr) = $JNI.jstring(l)
stadef jobject (l:addr) = $JNI.jobject(l)

(* ****** ****** *)
//
// HX-2013-08:
// [eval] is declared in Java class [Calculator]
//
extern
fun JNI_eval{l1,l2:addr}
(
  env: !JNIEnvPtr, obj: !jobject l1, inp: jstring l2
) : double = "ext#Java_Calculator_eval" // endfun

(* ****** ****** *)

implmnt
JNI_eval
  (env, obj, inp) = let
//
val () = assertloc ($JNI.jstring2ptr(inp) > 0)
//
val (pf | inp2) = $JNI.GetStringUTFChars (env, inp)
val opt = $CALC.aexp_parse_string ($UN.strptr2string(inp2))
val () = $JNI.ReleaseStringUTFChars (pf | env, inp, inp2)
//
in
//
case+ opt of
| ~Some_vt (ae) =>
    $CALC.aexp_eval (ae)
//
| ~None_vt ((*void*)) => let
    val (
    ) = $JNI.RaiseExceptionByClassName
      (env, "java/lang/IllegalArgumentException", "ParsingError")
    // end of [val]
  in
    0.0 (*deadcode*)
  end // end of [None_vt]
//
end (* end of [JNI_eval] *)

(* ****** ****** *)

%{$
//
// HX: This is ATS runtime:
//
#include "pats_ccomp_runtime.c"
#include "pats_ccomp_runtime2_dats.c"
#include "pats_ccomp_runtime_memalloc.c"
#include "pats_ccomp_runtime_trywith.c"
%}

(* ****** ****** *)

(* end of [Calculator.dats] *)
