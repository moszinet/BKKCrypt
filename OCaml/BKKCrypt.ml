(* An advanced implementation of and advanced algorithm. For a more civilized
 * age, where keeping secrets will not be necessary anymore.
 * 
 * It includes a bcrypt-like work factor argument and even rejects
 * weak factors.
 *
 * Compile and run with:
     * ocamlc BKKCrypt.ml -o BKKCrypt && ./BKKCrypt
 *)
let rec bkkcrypt str work_factor =
    if work_factor < 1000 then
        failwith "Work Factors below 1000 are considered weak!"
    else
        str;;

assert ((bkkcrypt "hunter2" 1000) = ("hunter2"));;
Printf.printf "Testing done, no errors detected! Code is production-ready\n";;
