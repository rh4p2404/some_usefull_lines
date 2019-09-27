#!/bin/bash

years=("""список годов """)
for year in ${years[*]}; do
	#beeline -u "jdbc:hive2://bda41node04:10000/;principal=hive/bda41node04.moscow.alfaintra.net@moscow.alfaintra.net" -e 'select' -hivevar day=${day}
	beeline -u "jdbc:hive2://bda41node04:10000/;principal=hive/bda41node04.moscow.alfaintra.net@moscow.alfaintra.net" --outputformat=tsv2 \
	-e 'select day, count(*) from <tbl_name> where day >=${year}0101 and day <=${year}0630 group by day order by day desc;' -hivevar year=${year} > ~/wsrm_stats_${year}_1.txt
	beeline -u "jdbc:hive2://bda41node04:10000/;principal=hive/bda41node04.moscow.alfaintra.net@moscow.alfaintra.net" --outputformat=tsv2 \
	-e 'select day, count(*) from <tbl_name> where day >=${year}0701 and day <=${year}1231 group by day order by day desc;' -hivevar year=${year} > ~/wsrm_stats_${year}_2.txt
	python /home/l_hdb/wsrm_stats_create.py ${year} 
	impala-shell -i bda41node03  -f /home/l_hdb/<tbl_name>_stats_${year}_1.sh
	impala-shell -i bda41node03  -f /home/l_hdb/<tbl_name>_stats_${year}_2.sh
done
