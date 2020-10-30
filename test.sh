#!/use/bin/env bash

# test sql query
./run.sh @/share/config/tests/impexp-opts-sql.txt

# xml query
./run.sh @/share/config/tests/impexp-opts-sql.txt

# bbox
./run.sh @/share/config/tests/impexp-opts-bbox.txt
