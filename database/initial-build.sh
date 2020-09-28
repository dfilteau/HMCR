#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -Q "CREATE DATABASE HMR_DEV"

for dir in V*/; do
    for f in ./$dir/*.sql; do
        /opt/mssql-tools/bin/sqlcmd -I -S localhost -U SA -P Forever21! -i $f;
    done;
done;

/opt/mssql-tools/bin/sqlcmd -I -S localhost -U SA -P Forever21! -i create-user.sql;

#/opt/mssql-tools/bin/sqlcmd -I -S localhost -U SA -P Forever21! -i "Hangfire scripts.txt";