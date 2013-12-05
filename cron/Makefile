lib_dirs := $(shell ls -m lib/ | sed 's/, /,lib\//g' | sed 's/^/lib\//')

make_coeffs.byte: make_coeffs.ml
	ocamlbuild -use-ocamlfind -pkg sqlite3 -pkg num -Is ${lib_dirs} \
			make_coeffs.byte
