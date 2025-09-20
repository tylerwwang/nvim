# Usage has_child "$base" "$target"
has_child() {
    # Absolute path of base file
    base_abs="$1"
    base_dir=$(dirname "$base_abs")

    target_abs="$2"
	target=$(perl -MCwd -e 'use File::Spec; print File::Spec->abs2rel($ARGV[0], $ARGV[1])' "$target_abs" "$base_dir")
	target_no_ext="${target%.tex}"

    visited=""

    _gather_recursive() {
        local current="$1"
		local exitcode=1

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


		if [ "$rel_path" = "$target" ] || [ "$rel_path" = "$target_no_ext" ]; then
			return 0
		fi

        # Parse \input{} and \include{} lines
		local includes=$(grep -E '\\(input|include){' "$current" 2>/dev/null \ | sed -E 's/.*\\(input|include){([^}]*)}.*/\2/')

		# Loop over each line safely
		IFS='
		'
		for rel in $includes; do
		    [ -z "$rel" ] && continue

		    # Resolve relative to base_dir
		    local child="$base_dir/$rel.tex"
		    [ -f "$base_dir/$rel" ] && child="$base_dir/$rel"

		    # Absolute path
		    local child_abs=$(perl -MCwd -e 'print Cwd::abs_path(shift)' "$child" 2>/dev/null)
		    [ -n "$child_abs" ] || continue

		    # Recurse
		    if _gather_recursive "$child_abs"; then
				return 0
		    fi
		done

		return 1
    }

    if _gather_recursive "$base_abs"; then
		return 0
	else
		return 1
	fi
}

# Usage find_root "$file"
find_root() {
	local file="$1"

	if [ -z "$file" ]; then
	    return 1
	fi

	# Normalize input to absolute path
	local absfile=$(perl -MCwd -e 'print Cwd::abs_path(shift)' "$file")

	local dir=$(dirname "$absfile")
	local name=$(basename "$absfile")

	# Walk upward until we reach $HOME
	while [ "$dir" != "$HOME" ] && [ "$dir" != "/" ]; do
	    # Search all .tex files in this directory for \documentclass
	    for candidate in "$dir"/*.tex; do
	        [ -f "$candidate" ] || continue
	        if grep -q '\\documentclass' "$candidate"; then
	            # Now check: does this candidate include our input file (directly or indirectly)?
	            if has_child "$candidate" "$absfile"; then
	                echo $candidate
					return 0
	            fi
	        fi
	    done
	    dir=$(dirname "$dir")
	done

	return 1
}

find_root "$1"
