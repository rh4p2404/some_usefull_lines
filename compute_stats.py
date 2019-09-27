import sys
year=sys.argv[1]
parts=open('/home/l_hdb/<tbl_name>_stats_{0}_1.txt'.format(year),'r')
fres=open('/home/l_hdb/<tbl_name>_{0}_1.sh'.format(year),'w')
for day in parts.readlines()[1:]:
	fres.write("alter table <tbl_name> partition (day={0}) set tblproperties ('numRows'='{1}');\n".format(day.strip().split("\t")[0],format(day.strip().split("\t")[1])))
fres.close()
parts.close()
parts=open('/home/l_hdb/<tbl_name>_stats_{0}_2.txt'.format(year),'r')
fres=open('/home/l_hdb/<tbl_name>_{0}_2.sh'.format(year),'w')
for day in parts.readlines()[1:]:
	fres.write("alter table <tbl_name> partition (day={0}) set tblproperties ('numRows'='{1}');\n".format(day.strip().split("\t")[0],format(day.strip().split("\t")[1])))
fres.close()
parts.close()
