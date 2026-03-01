#!/bin/bash
# extract.sh - Extract any archive to its own folder
# Works as a Thunar custom action or standalone CLI tool
#
# Usage: extract.sh <archive1> [archive2] ...
# Each archive is extracted to a folder named after it in the same directory

extract_file() {
    local archive="$1"
    local dir="$(dirname "$archive")"
    local base="$(basename "$archive")"

    # Strip known extensions to get folder name
    local folder_name
    folder_name="$base"
    folder_name="${folder_name%.tar.gz}"
    folder_name="${folder_name%.tar.bz2}"
    folder_name="${folder_name%.tar.xz}"
    folder_name="${folder_name%.tar.zst}"
    folder_name="${folder_name%.tar.lz4}"
    folder_name="${folder_name%.tar.lzma}"
    folder_name="${folder_name%.tar}"
    folder_name="${folder_name%.gz}"
    folder_name="${folder_name%.bz2}"
    folder_name="${folder_name%.xz}"
    folder_name="${folder_name%.zst}"
    folder_name="${folder_name%.zip}"
    folder_name="${folder_name%.ZIP}"
    folder_name="${folder_name%.rar}"
    folder_name="${folder_name%.RAR}"
    folder_name="${folder_name%.7z}"
    folder_name="${folder_name%.7Z}"
    folder_name="${folder_name%.lz4}"
    folder_name="${folder_name%.lzma}"
    folder_name="${folder_name%.Z}"
    folder_name="${folder_name%.cbz}"
    folder_name="${folder_name%.cbr}"

    local dest="$dir/$folder_name"

    # Avoid overwriting existing folder — append number if needed
    if [[ -e "$dest" ]]; then
        local i=1
        while [[ -e "${dest}_${i}" ]]; do
            ((i++))
        done
        dest="${dest}_${i}"
    fi

    mkdir -p "$dest"

    echo "Extracting: $base → $folder_name/"

    case "$base" in
        *.tar.gz|*.tgz)        tar -xzf "$archive"   -C "$dest" ;;
        *.tar.bz2|*.tbz2)      tar -xjf "$archive"   -C "$dest" ;;
        *.tar.xz|*.txz)        tar -xJf "$archive"   -C "$dest" ;;
        *.tar.zst)             tar --zstd -xf "$archive" -C "$dest" ;;
        *.tar.lz4)             lz4 -d "$archive" | tar -x -C "$dest" ;;
        *.tar.lzma)            tar --lzma -xf "$archive" -C "$dest" ;;
        *.tar)                 tar -xf "$archive"    -C "$dest" ;;
        *.gz)                  gunzip -c "$archive" > "$dest/$folder_name" ;;
        *.bz2)                 bunzip2 -c "$archive" > "$dest/$folder_name" ;;
        *.xz)                  unxz -c "$archive" > "$dest/$folder_name" ;;
        *.zst)                 zstd -d "$archive" -o "$dest/$folder_name" ;;
        *.lz4)                 lz4 -d "$archive" "$dest/$folder_name" ;;
        *.lzma)                unlzma -c "$archive" > "$dest/$folder_name" ;;
        *.Z)                   uncompress -c "$archive" > "$dest/$folder_name" ;;
        *.zip|*.ZIP|*.cbz)     unzip -q "$archive" -d "$dest" ;;
        *.rar|*.RAR|*.cbr)
            if command -v unrar &>/dev/null; then
                unrar x -y "$archive" "$dest/"
            elif command -v rar &>/dev/null; then
                rar x -y "$archive" "$dest/"
            else
                echo "ERROR: unrar not found. Install with: paru -S unrar" >&2
                rmdir "$dest" 2>/dev/null
                return 1
            fi
            ;;
        *.7z|*.7Z)
            if command -v 7z &>/dev/null; then
                7z x "$archive" -o"$dest" -y
            elif command -v 7za &>/dev/null; then
                7za x "$archive" -o"$dest" -y
            else
                echo "ERROR: 7zip not found. Install with: paru -S 7zip" >&2
                rmdir "$dest" 2>/dev/null
                return 1
            fi
            ;;
        *)
            echo "ERROR: Unknown archive format: $base" >&2
            rmdir "$dest" 2>/dev/null
            return 1
            ;;
    esac

    local exit_code=$?
    if [[ $exit_code -eq 0 ]]; then
        echo "Done: $dest"
        # Open the folder in Thunar after extraction
        thunar "$dest" &
    else
        echo "ERROR: Extraction failed for $base" >&2
        # Clean up empty folder on failure
        rmdir "$dest" 2>/dev/null
    fi

    return $exit_code
}

# --- Main ---
if [[ $# -eq 0 ]]; then
    echo "Usage: extract.sh <archive> [archive2] ..."
    echo ""
    echo "Supported formats:"
    echo "  zip, rar, 7z, tar, tar.gz, tar.bz2, tar.xz, tar.zst,"
    echo "  gz, bz2, xz, zst, lz4, lzma, Z, cbz, cbr"
    exit 1
fi

errors=0
for archive in "$@"; do
    if [[ ! -f "$archive" ]]; then
        echo "ERROR: File not found: $archive" >&2
        ((errors++))
        continue
    fi
    extract_file "$archive" || ((errors++))
done

exit $errors
