#!/bin/sh
mysqldump -h mysql --user=root --password=root --all-databases > /shared/backups/mysql/all-databases.sql