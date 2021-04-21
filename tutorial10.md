# EE4791 Database Systems - Tutorial 10 Questions

## Question

 1. Identify the key differences between logical database design and physical database design. 
 2. State the major tasks to be carried out in physical database design and the methods that may be applied in each task. 
 3. Explain the difference between a static web page and a dynamic one. 
 4. Contrast the following terms in client-server architecture: 
			a) Two-tier architecture; three-tier architecture. 
			b) Fat client; thin client. 
			c) SQL; Java. 
5. More examples will be presented for SQL.


## Answer

### Identify the key differences between logical database design and physical database design.

The purpose of the **physical database design** is to translate the logical description of data into the technical specifications for storing and retrieving data. It's goal is the create a design for storing data that will provide adequate performance and ensure database integrity, security and recoverability.

**Logical database design** is the process or transforming(or mapping) a conceptual **schema** of the application domain into a **schema** for the data model underlying a particular DBMS, such as the relational or object-oriented data model.

#### State the major tasks to be carried out in physical database design and the methods that may be applied in each task.

1. **Designing data fields**
	* Data field integrity
		1.	Defaut value - assumed value if no explicit value
		2.	Range control - allowable value limitations(constraints or validation rules)
		3.	Null value control - allowing or prohibiting empty fields
		4.	Referential integrity - range control (and null value allowances) for foreign key and primary key to match up.
	* Handling Missing data
		1.	 Substitute an estimate of the missing value (e.g. using a formula)
		2.	Construct a report listing missing values
		3.	In programs, ignore missing data unless the value is significant (sensitivity testing)
	* Include data type

2. Performance/efficiency improvement
	* Denormalisation
		*  **Usage analysis and data volume**
	In the physical database design, we have to estimate the volume and estimate the amount of access for each table. Hence, the method that we use is the **usage analysis and data volume**. 
			* Here, we create usage maps by modifying ER diagrams to include information regarding the size of entities (e.g. number of instances) as well as frequencies of use of these entities. 
			* This way, we come to an understanding of the storage needs, as well as the computational demand of the system.
![composite usage map](https://slideplayer.com/slide/6389748/22/images/7/Figure+6-1+Composite+usage+map.jpg)
	* Partitioning
		1. Horizontal partitioniong 
			* Distributing the rows of a logical relation into several separate tables
			* Useful for situations where different users need access to different rows 
		2. Vertical partioning
			* Distrubuting the columns of a logical relation into several separate physical tables
			* Useful for situations where different users need access to different columns
			* The primary key must be repeated in each file
		3. Combination of horizontal and vertical 
		
3. Design physical database files
	1. Unordered
		* Also called a heap or a pile file
		* New records are inserted at the end of the file
		* A linear search through the file records is necessary to search for a record
	2. Ordered
		* File records are kept sorted by the values of an ordering field
		* A binary search can be used to search for a record on its ordering field value
	3. Hashed
		* The file blocks are divided into M equalsized buckets, numbered bucket<sub>0</sub> , bucket<sub>1</sub> , ..., bucket<sub>M-1</sub>
	4. Clustering 
4. Indexes
	* Primary index should be for  primary keys
	* Secondary index should be for frequently searched fields
5. Query optimization
	* Parallel query processing
		* **Parallel query** is a method used to increase the execution speed of SQL **queries** by creating multiple **query** processes that divide the workload of a SQL statement and executing it in **parallel** or at the same time.


### Explain the difference between a static web page and a dynamic one. 

Websites are separated into two different types: static and dynamic. **Static** websites are the ones that are fixed and display the same content for every user, usually written exclusively in HTML. A **dynamic** website, on the other hand, is one that can display different content and provide user interaction, by making use of advanced programming and databases in addition to HTML. As you can tell, static websites are easier to create, while dynamic websites require more work.


### Contrast the following terms in client-server architecture: 
#### a) Two-tier architecture; three-tier architecture. 

Two-tier client-server environment
* Processing logic could be at client(fat client), server (thin client) or both (distributed environment)
* ![enter image description here](http://3.bp.blogspot.com/-JJL5RmIgCtU/VCy5UpRcepI/AAAAAAAAAVA/9k_M4vK2QPU/s1600/2.jpg)

Three-tier client-server environment
* Processing logic will be at application server or Web server
* ![enter image description here](https://miro.medium.com/max/3828/1*3E4w7rCe3eaz6gLlZoe6nQ.png)


#### b) Fat client; thin client. 

A thin client is software that is primarily designed to communicate with a server. Its features are produced by servers such as a cloud platfrom

A thick client is software that implements its own features. It may connect to servers but it remains mostly functional when disconnected.


#### c) SQL; Java.

SQL is an acronym for Structured Query Language. It can only be used to manage database related operations. There are various variants of SQL available such as MySQL, PostGreSQL etc

Java is a high level, platform independent, object oriented programming language. It can be used to write programs in various domains like desktop applications, android applications, web applets etc. You can use Java to connect to the database by using SQL queries and libraries

## Teacher's Answer
1. **Logical database design** is to establish an ER diagram and a set of 3NF relations (relational schema). No redundancy should be included in logical design(normalisation).

	**Physical database design** is to enhance the performance, database integrity, security and resources, etc. Some redundancy may be introduced in physical database design for performance reasons (e.g. denormalisation, indexes) 
2. 
3. A static web page is fixed in time and cannot include information that change with time or user input, i.e., a web page ending with *.htm and *.html. 

	A dynamic page includes information that changes with time and/or user input, therefore allowing the display of data from querying and storage of user input, i.e., a dynamic web page is an output of a program, that is, a web page ending with *.php, *.asp, *.jsp, etc..
	
4. 
	1.  Two-tier architecture consists of 1 client plus 1 server, i.e. distributes presentation logic on the client, storage logic(database) on the server, and then places the procssing logic either on the client, server or distributed between the server and client. Three-tier architectures consist of 1 client plus 2 servers, i.e. include another server in addition to the client and database server; usually, processing logic or application programs resides and runs on the additional server.
	
	2. A distinction among client capabilities that is based on processing capabilities, a fat client is responsible for more processing - including presentation logic, extensive application logic, and business rules logic
		* A thin client is responsible for much less processing, usually only presentation logic ( i.e. display of a web page)

	3.	SQL is a standard language for creating and querying relational databases. Java is a general-purpose programming language.
	
