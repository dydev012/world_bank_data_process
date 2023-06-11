# Background

This repo contains the SQL processing files used in my project processing World Bank IDBR & IDA data.
Both the data sources can be found here:
* IBDR Loans: https://finances.worldbank.org/Loans-and-Credits/IBRD-Statement-of-Loans-Latest-Available-Snapshot/sfv5-tf7p
* IDA Credits & Grants: https://finances.worldbank.org/Loans-and-Credits/IDA-Statement-of-Credits-and-Grants-Latest-Availab/ebmi-69yj

To replicate Processing Steps:
1) Download Data as above
2) Create a databse named "WorldBank"
3) Save Loans under a "Loans" Table and IDA under a "Credits" Table
4) Run: initDB.sql -> createProjectsTable.sql -> combineData.sql
5) Use the resulting "CombinedView" and "Projects" Views for data analysis.
