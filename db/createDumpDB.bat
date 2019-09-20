echo %DATE%
echo %TIME%
set datetimef=%date:~-4%_%date:~3,2%_%date:~0,2%
echo %datetimef%
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" --routines    -u root -p is2 > "G:\worspaces_eclipse\ws_eclipse_oxygen\is2\db\is2_ruleset.sql"