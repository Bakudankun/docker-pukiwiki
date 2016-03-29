#!/bin/bash
set -e

if [[ "$1" == apache2* ]]; then
	if ! [ -e index.php -a -e wp-includes/version.php ]; then
		echo >&2 "PukiWiki not found in $(pwd) - copying now..."
		if [ "$(ls -A)" ]; then
			echo >&2 "WARNING: $(pwd) is not empty - press Ctrl+C now if this is an error!"
			( set -x; ls -A; sleep 10 )
		fi
		tar cf - --one-file-system -C /usr/src/pukiwiki-${PUKIWIKI_VERSION}_utf8 . | tar xf -
		echo >&2 "Complete! PukiWiki has been successfully copied to $(pwd)"
	fi
fi

exec "$@"
