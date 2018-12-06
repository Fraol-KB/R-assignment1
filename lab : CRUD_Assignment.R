

# Import library
library(RMySQL)


# Create the connection object to the database where we want to create the table.
mysqlconnection = dbConnect(MySQL(), user = 'root', password = '', dbname = 'tradechain', 
                            host = '127.0.0.1')

# Initial Database List
dbListTables(mysqlconnection)














# Create 3 tables 
# Table 1
dbSendQuery(mysqlconnection, "create table customers (
            id int not null auto_increment primary key, 
            name varchar(20),
            city varchar(20),
            amount int,
            agent_id int)" )

#List of tables
dbListTables(mysqlconnection)



#Table 2
dbSendQuery(mysqlconnection, "create table agents(
            id int not null auto_increment primary key,
            name varchar(20),
            address varchar(20))")

#List of tables
dbListTables(mysqlconnection)

# Table 3
dbSendQuery(mysqlconnection, "create table orders(
            id int not null auto_increment primary key,
            customer_id int,
            agent_id int,
            description varchar(250)
            )")

#List of tables
dbListTables(mysqlconnection)

















# Demonstrating CRUD operations

#Create     

dbSendQuery(mysqlconnection,"insert into customers(name, city, amount, agent_id)
            values('Essey', 'Hawassa', 500 , 1)                 
            ")
dbSendQuery(mysqlconnection,"insert into customers(name, city, amount, agent_id)
            values('Nati', 'Adama', 400 , 1)                 
            ")


dbSendQuery(mysqlconnection,"insert into agents(name, address)
            values('Fraol', 'Addis Ababa')                 
            ")

dbSendQuery(mysqlconnection,"insert into orders(customer_id, agent_id, description)
            values(1, 1, 'Detailed description of purchased item')                 
            ")





#Read

customers = dbSendQuery(mysqlconnection, "select * from customers")


data.frame = fetch(customers)
print(data.frame)

customer = dbSendQuery(mysqlconnection, "select * from customers where name = 'Essey'")
data.frame = fetch(customer)
print(data.frame)













#Update

#before
customers = dbSendQuery(mysqlconnection, "select * from customers")
data.frame = fetch(customers)
print(data.frame)
dbSendQuery(mysqlconnection, "update customers set name = 'Fraol' where id = 2")

#after
customers = dbSendQuery(mysqlconnection, "select * from customers")
data.frame = fetch(customers)
print(data.frame)









#Delete
#before
customers = dbSendQuery(mysqlconnection, "select * from customers")
data.frame = fetch(customers)
print(data.frame)
#after
dbSendQuery(mysqlconnection, "delete from customers where id = 2")
customers = dbSendQuery(mysqlconnection, "select * from customers")
data.frame = fetch(customers)
print(data.frame)











#performing operations on the the existing column to create a new one

data.frame$name_and_city <- paste(data.frame$name,"from",data.frame$city)


# create table with the modified data frame
dbWriteTable(mysqlconnection, 'customer_info', data.frame,row.names = TRUE)

# checking results
customers = dbSendQuery(mysqlconnection, "select * from customer_info")
data.frame = fetch(customers)
print(data.frame)





