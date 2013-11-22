(* @author holman
 *
 * Initializes our gender database
 * Data from: http://www.healthchecksystems.com/heightweightchart.htm
 *)

open Sqlite3

let eval_gender gender = match gender with
| "M" -> 1.0
| "F" -> -1.0
| _ -> assert false

let insert_people db input_file gender =
  let make_insert_query height weight gender = Printf.sprintf
    "INSERT INTO people(height, weight, gender, created_at, updated_at) \
      VALUES(%d, %d, '%s', datetime('now'), datetime('now'))"
    height weight gender
  in
  let in_channel = Scanf.Scanning.open_in input_file in
  try
    (* Format of file is:
     * 1. Height in feet inches (e.g. 5'2")
     * 2. Min-max of weight for lighter person (128-134)
     * 3.    "    "    "     "  medium person
     * 4.    "    "    "     "  heavier person
     *
     * This is repeated until no more entries
     * NOTE: I have to put this bogus " because OCaml comments are somehow
     *   so dumb that it needs an even number of quotes
     *)
    let feet_inches_to_inches feet inches = feet * 12 + inches in
    let process_height feet inches =
      let height = feet_inches_to_inches feet inches in

      (* We have the height, now iterate over the weights *)
      let process_weight weight =
        let query = make_insert_query height weight gender in
        match exec db query with
        | Rc.OK -> ()
        | _ -> assert false
      in
      let process_both_weights weight1 weight2 =
        process_weight weight1;
        process_weight weight2
      in
      for i = 1 to 3 do
        Scanf.bscanf in_channel "%d-%d\n" process_both_weights
      done
    in
    while not (Scanf.Scanning.end_of_input in_channel) do
      Scanf.bscanf in_channel "%d'%d\"\n" process_height
    done;
    Printf.printf "*** Done inserting %s ***\n%!" input_file
  with e -> assert false

let () =
  let db = db_open ~mode:`NO_CREATE "../production.sqlite3"
  in
  try
    (* Clear the db *)
    match exec db "DELETE FROM people" with
    | Rc.OK ->
        print_endline "*** Database cleared ***";

        (* Now insert everyone *)
        insert_people db "female.txt" "F";
        insert_people db "male.txt" "M"
    | _ -> assert false
  with xcp -> assert false
