#!/bin/bash -e

SQL=$(dirname $0)/schema.sql

mysql -u root --password=pass -B < $SQL
