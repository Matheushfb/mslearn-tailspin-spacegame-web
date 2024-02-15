import pyodbc


conn = pyodbc.connect('DRIVER={ODBC driver 18 for SQL Server};SERVER=advancedsharedev.cicbnvbklhye.us-east-1.rds.amazonaws.com;PORT=1433;UID=admin;PWD=Pa55w0rd!(;Encrypt=no',autocommit=True)
cursor = conn.cursor()
cursor.execute("CREATE DATABASE testematheus")

