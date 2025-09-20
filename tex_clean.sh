#!/bin/sh
# Usage: tex_clean.sh <file_without_extension>
# Finds the root file containing \documentclass and cleans all aux files recursively.

# --- Recursive cleanup ---

# List Children

# Usage gather_children $base
gather_children() {
    base_abs=$(perl -MCwd -e 'print Cwd::abs_path(shift)' "$1")
    base_dir=$(dirname "$base_abs")
    visited=""
	list=""

    _gather_recursive() {
        local current="$1"

        # Skip if already visited
        case ";$visited;" in
            *";$current;"*) return ;;
        esac
        visited="$visited;$current"

        # Print path relative to base_dir
		local rel_path=$(perl -MCwd -e '
		            use Cwd "abs_path";
		            use File::Spec;
		            my ($base, $file) = @ARGV;
		            my $rel = File::Spec->abs2rel($file, $base);
		            $rel =~ s/\.tex$//;
		            print $rel;
		        ' "$base_dir" "$current")

        # Parse \input{} and \include{} lines
		local includes=$(grep -E '\\(input|include){' "$current" 2>/dev/null \ | sed -E 's/.*\\(input|include){([^}]*)}.*/\2/')

		# Loop over each line safely
		IFS='
		'
		for rel in $includes; do
			list="$list$rel;"
		    [ -z "$rel" ] && continue

		    # Resolve relative to base_dir
		    local child="$base_dir/$rel.tex"
		    [ -f "$base_dir/$rel" ] && child="$base_dir/$rel"

		    # Absolute path
		    local child_abs=$(perl -MCwd -e 'print Cwd::abs_path(shift)' "$child" 2>/dev/null)
		    [ -n "$child_abs" ] || continue

		    # Recurse
		    _gather_recursive "$child_abs"
		done
    }

	_gather_recursive "$base_abs"
	echo $list
}

remove() {
	rm -f \
	  "$1.cb" "$1.cb2" "$1.spl" "$1.nav" "$1.snm" \
	  "$1.tdo" "$1.nmo" "$1.brf" "$1.nlg" "$1.nlo" "$1.nls" \
	  "$1.synctex.gz" "$1.run.xml" "$1.log" "$1.aux" "$1.fls" \
	  "$1.out" "$1.fdb_latexmk" "$1.bbl" "$1.blg" "$1.bcf" \
	  "$1.toc" "$1.lof" "$1.lot" "$1.acn" "$1.acr" "$1.alg" \
	  "$1.gls" "$1.glo" "$1.ist"
}

# Usage clean_aux $root
clean_aux() {
	local base="$1"
	local texfile="$base.tex"
	local children=$(gather_children "$texfile")

	remove "$base"

	base_dir=$(dirname "$base")

    IFS=';' read -ra parts <<< "$children"
    for child in "${parts[@]}"; do
        remove "$base_dir/$child"
    done
}

# --- Entry point ---
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>" >&2
  exit 1
fi

if [ ! -f "$1" ]; then
    echo "File does not exist: $1"
    exit 1
fi

clean_aux "${1%.tex}"
