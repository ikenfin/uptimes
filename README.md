# uptimes

**uptimes** is bash script that prints uptime history.

Script based on `last` program and `awk` script.

## Example

Calling without arguments

`$ sh uptimes.sh`

	up 10:18
	up 2 day, 03:33

Calling with `-s or --short` argument

`$ sh uptimes.sh -s`

	Started at Wed May 27 2015 22:58:56 up 10:21
	Started at Mon May 25 2015 19:21:32 up 2 day, 03:33

Calling with `-f or --full` argument

`$ sh uptimes.sh -f`

	Started at Wed May 27 2015 22:58:56 To Thu May 28 2015 09:42:33 up 10:43
	Started at Mon May 25 2015 19:21:32 To Wed May 27 2015 22:54:32 up 2 day, 03:33

