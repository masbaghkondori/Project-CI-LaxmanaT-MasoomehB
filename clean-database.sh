 #!/bin/bash
cd /home/robot/workspace/Project-CI-LaxmanaT-MasoomehB/hoteljsf
Mvn clean install
cd target
asadmin deploy -–force=true hotel.war
export PGPASSWORD=postgres
psql -h localhost -U postgres hotel -f database-backup.sql
cd /home/robot/workspace/Project-CI-LaxmanaT-MasoomehB/robot-frontend
pybot  00_regression_tests.robot
cd /home/robot/workspace/Project-CI-LaxmanaT-MasoomehB/hotel-restfull





