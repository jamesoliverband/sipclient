package com.genius.core
{
	import com.genius.model.ApplicationModel;
	import com.genius.model.Batch;
	import com.genius.model.Course;
	import com.genius.model.MonthView;
	import com.genius.model.SQLQueries;
	import com.genius.model.Student;
	import com.genius.model.StudentBatch;
	import com.genius.model.Teacher;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class DataManager
	{
		
		private static var model:ApplicationModel = ApplicationModel.instance;
		
		public function DataManager()
		{
		}
		
		public static  function createDatabase(createNew:Boolean):void {
			// Create a file to hold the database
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			//dbFile.deleteFile();
			Alert.show("DBFILE - " + dbFile.nativePath );
			if(!dbFile.exists || dbFile == null || createNew ) {
				trace("Path" + dbFile.nativePath)
				//dbFile.deleteFile();
			
				var sipDb:SQLConnection = new SQLConnection();
				// Creates the dataabase with the specified file above
				sipDb.open(dbFile);
				
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sipDb;
				// Create a table to map to our Students value object
				stmt.text = SQLQueries.C_STUDENT;
				
				
				stmt.execute();
				
				var stmtC:SQLStatement = new SQLStatement();
				stmtC.sqlConnection = sipDb;
				// Create a table to map to our Students value object
				stmtC.text = SQLQueries.C_COURSE;
				stmtC.execute();
				
				stmtC = new SQLStatement();
				stmtC.sqlConnection = sipDb;
				// Create a table to map to our Students value object
				stmtC.text = SQLQueries.C_TEACHER;
				stmtC.execute();
				
				stmtC = new SQLStatement();
				stmtC.sqlConnection = sipDb;
				// Create a table to map to our Students value object
				stmtC.text = SQLQueries.C_BATCH;
				stmtC.execute();
				
				
				stmtC = new SQLStatement();
				stmtC.sqlConnection = sipDb;
				// Create a table to map to our Students value object
				stmtC.text = SQLQueries.C_STD_BATCH;
				stmtC.execute();
				
				stmtC = new SQLStatement();
				stmtC.sqlConnection = sipDb;
				// Create a table to map to our Students value object
				stmtC.text = SQLQueries.C_MONTH_VIEW;
				stmtC.execute();
				//createOneYearPlan("JAN","2011",0,0);
				
				stmtC = new SQLStatement();
				stmtC.sqlConnection = sipDb;
				// Create a table to map to our Students value object
				stmtC.text = SQLQueries.C_EXPENSES;
				stmtC.execute();
				
				
				createCourseData();
			}
			
			
		}

		public static function createCourseData():void {
			addNewCourse(getCourse("00","AMAL",2000,"AMAL"));
			addNewCourse(getCourse("01","Level 1",2300,"Level 1"));
			addNewCourse(getCourse("02","Level 2",2000,"Level 2"));
			addNewCourse(getCourse("03","Level 3",2000,"Level 3"));
			addNewCourse(getCourse("04","Level 4",2000,"Level 4"));
			addNewCourse(getCourse("05","Adv. Level 1",2000,"Adv. Level 1"));
			addNewCourse(getCourse("06","Adv. Level 2",2000,"Adv. Level 2"));
			addNewCourse(getCourse("07","Adv. Level 3",2000,"Adv. Level 3"));
			addNewCourse(getCourse("08","Adv. Level 4",2000,"Adv. Level 4"));
		}

		public static function getCourse(id:String,name:String,fees:Number, desc:String):Course {
			var c:Course = new Course();
			c.coursename = name;
			c.fees = fees;
			c.description=desc;
			c.id = id;
			return c;
		}
		
		// Insert a row into the Student table
		public static  function addStudent(student:Student):String
		{
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.I_STUDENT; 
			
			var date:Date = new Date();
			var stdId:String = ""
			if(student.id == null || student.id=="") {
				stdId = generateStudentId(student.enrolldate);
			} else {
				stdId = student.id;
			}
			stmt.parameters[0] = stdId;
			stmt.parameters[1] = student.firstname;
			stmt.parameters[2] = student.lastname;
			stmt.parameters[3] = student.middlename;
			stmt.parameters[4] = student.dob;
			stmt.parameters[5] = student.enrolldate;
			stmt.parameters[6] = student.level;
			stmt.parameters[7] = student.contactnumber1;
			stmt.parameters[8] = student.contactnumber2;
			stmt.parameters[9] = student.contactnumber3;
			stmt.parameters[10] = student.schoolname;			
			stmt.execute();
			return stdId;
		}
		
		
		// Insert a row into the Student table
		public static function generateStudentId(enrollDate:String):String
		{
			var branchId:String = model.branchId;
			//var date:Date = new Date();
			var year:String = enrollDate.substr(6);
			var yearShort:String = enrollDate.substr(8);
			
			trace("Year = " + year);
			trace("Year = " + yearShort);
			//var month:String = date.month
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			
			stmt.text = "Select count(*) as count from students where enrolldate like '%" + year + "'";
			//stmt.text = "Select count(*) as count from students";
			stmt.execute();
			
			var count:uint = 0;
			var data:Array = stmt.getResult().data;
			if(data!= null && data.length > 0) {
				count = data.pop().count;
			}
			var nextCount:uint = count+1;
			var prefix:String = "";
			if(nextCount>9) {
				if(nextCount < 100) {
					prefix="0"
				}
			} else {
				prefix="00"
			}
			return branchId + yearShort + prefix + nextCount; 
		}
		
		// Insert a row into the Student table
		public static  function updateStudent(student:Student):void
		{
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.U_STUDENT; 
			stmt.parameters[0] = student.firstname;
			stmt.parameters[1] = student.lastname;
			stmt.parameters[2] = student.middlename;
			stmt.parameters[3] = student.dob;
			stmt.parameters[4] = student.contactnumber1;
			stmt.parameters[5] = student.contactnumber2;
			stmt.parameters[6] = student.contactnumber3;
			stmt.parameters[7] = student.schoolname;
			stmt.parameters[8] = student.id;
			stmt.execute();
		}
		
		// Insert a row into the Student Batch Table
		public static  function addStudentToBatch(stdBatch:StudentBatch):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			

			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = "select * from student_batch where studentid=? and batchid=?"; 
			stmt.parameters[0] = stdBatch.studentid;
			stmt.parameters[1] = stdBatch.batchid;
			stmt.execute();
			

			var students:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(students!=null && students.length > 0) {
				//return null; Do Nothing. Already Present.
			} else {
				var stmt:SQLStatement = new SQLStatement();
				stmt.sqlConnection = sipDb;
				stmt.text = SQLQueries.I_STUDENT_BATCH; 
				
				stmt.parameters[0] = stdBatch.studentid;
				stmt.parameters[1] = stdBatch.batchid;
				stmt.parameters[2] = stdBatch.fees;
				stmt.parameters[3] = stdBatch.amountpaid
				stmt.parameters[4] = stdBatch.discount
				stmt.parameters[5] = "11/01/11";
				
				stmt.execute();
			}
			
			
			
		}

		// Insert a row into the Student table
		public static function addNewCourse(course:Course):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.I_NEW_COURSES; 
			
			stmt.parameters[0] = course.id;
			stmt.parameters[1] = course.coursename;
			stmt.parameters[2] = course.description;
						
			stmt.execute();
			
		}
		
		
		// Insert a row into the Student table
		public static function addNewExpense(expenseHead:String, amount:Number, expenseDate:String,remarks:String):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.I_NEW_EXPENSE; 
			stmt.parameters[0] = expenseHead;
			stmt.parameters[1] = amount;
			stmt.parameters[2] = expenseDate;
			stmt.parameters[3] = remarks;
			stmt.execute();
		}
		
		// Insert a row into the Student table
		public static function addNewBatch(batch:Batch):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.I_BATCH;
			stmt.parameters[0] = generateBatchId(batch);
			stmt.parameters[1] = batch.teachername
			stmt.parameters[2] = batch.coursename;
			stmt.parameters[3] = batch.startdate
			stmt.parameters[4] = batch.enddate
			stmt.parameters[5] = batch.days
			stmt.parameters[6] = batch.time
			stmt.parameters[7] = batch.runningstatus;
			stmt.execute();
		}
		
		protected static function generateBatchId(batch:Batch):String
		{
			var branchId:String = model.branchId;
			var date:Date = new Date();
			var year:String = date.fullYear + "";
			//var month:String = date.month
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			
			var matchingId:String = branchId + batch.startdate.substr(6,4);
			
			//stmt.text = "Select count(*) as count from students where enrolldate like '%" + year + "'";
			stmt.text = "Select count(*) as count from batch where id like '" + matchingId + "%'";
			stmt.execute();
			
			var count:uint = 0;
			var data:Array = stmt.getResult().data;
			if(data!= null && data.length > 0) {
				count = data.pop().count;
			}
			var nextCount:uint = count+1;
			var prefix:String = "";
			if(nextCount>9) {
				if(nextCount < 100) {
					prefix="0"
				}
			} else {
				prefix="00"
			}
			return branchId + year + prefix + nextCount; 
		}
		
		
		// Insert a row into the Student table
		public static function updateCourse(course:Course):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.U_COURSE; 
			stmt.parameters[0] = course.coursename;
			stmt.parameters[1] = course.description;
			stmt.parameters[2] = course.id;
			trace("courseId" + course.id);
			stmt.execute();
		}
		
		// Insert a row into the Student table
		public static function addNewTeacher(teacher:Teacher):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
						
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.I_NEW_TEACHER; 
		
			stmt.parameters[0] = teacher.teachername;
			stmt.parameters[1] = teacher.dob;
			stmt.parameters[2] = teacher.qualification;
			stmt.parameters[3] = teacher.address;
			stmt.parameters[4] = teacher.experience;
			stmt.parameters[5] = teacher.mobile;
				
			stmt.execute();
			
		}
		
		// Insert a row into the Student table
		public static function updateTeacher(teacher:Teacher):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.U_TEACHER; 
			stmt.parameters[0] = teacher.teachername;
			stmt.parameters[1] = teacher.dob;
			stmt.parameters[2] = teacher.qualification;
			stmt.parameters[3] = teacher.address;
			stmt.parameters[4] = teacher.experience;
			stmt.parameters[5] = teacher.mobile;
			stmt.parameters[6] = teacher.id;
			
			stmt.execute();
			
		}
		
		public static function updateBatch(bacth:Batch):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.U_BATCH; 
			stmt.parameters[0] = bacth.teachername;
			stmt.parameters[1] = bacth.coursename;
			stmt.parameters[2] = bacth.startdate;
			stmt.parameters[3] = bacth.enddate;
			stmt.parameters[4] = bacth.days;
			stmt.parameters[5] = bacth.time;
			stmt.parameters[6] = bacth.id;
			
			stmt.execute();
			
		}
		
		// Insert a row into the Student table
		public static function markBatchComplete(batchId:String):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.U_MARK_BATCH_COMPLETE; 
			stmt.parameters[0] = batchId;
			stmt.execute();
		}
		
		// Insert a row into the Student table
		public static function markStudentInactive(studentId:String):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.U_STUDENT_MARK_DROPED; 
			stmt.parameters[0] = studentId;
			stmt.execute();
		}
		
		// Insert a row into the Student table
		public static function updateStudentCurrentLevel(studentId:String, currentLevel:String):void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.U_STUDENT_CURRENT_LEVEL; 
			stmt.parameters[0] = studentId;
			stmt.parameters[1] = currentLevel;
			stmt.execute();
		}


		
		public static function getCurrentMonthBirdays():ArrayCollection{
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			var d:Date = new Date();
			var month:Number = d.month;
			month = month + 1;
			var monthStr:String = month+"";
			if(month < 10 ) {
				monthStr = "0" + monthStr;
			}
			
			stmt.text = SQLQueries.S_STUDENT_CUR_MONTH_BDAY_1 + monthStr + SQLQueries.S_STUDENT_CUR_MONTH_BDAY_2;
			stmt.execute();
			var bdayStudents:ArrayCollection= new ArrayCollection(stmt.getResult().data);
			if(bdayStudents!=null) {
				trace(bdayStudents.length);
			}
			return bdayStudents;
			
		}
		
		public static function getBatch(batchId:String) : Batch {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Batch;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_BATCH;
			stmt.parameters[0] =  batchId ;
			stmt.execute();
			var batches:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(batches!=null) {
				return batches.getItemAt(0) as Batch;
			} else {
				return null;
			}
			
			//return courses;
		}
		
		public static function getStudentForId(studentId:String) : Student {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_STUDENT_FOR_ID;
			stmt.parameters[0] =  studentId ;
			stmt.execute();
			var students:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(students!=null) {
				return students.getItemAt(0) as Student;
			} else {
				return null;
			}
			
			//return courses;
		}
		
		public static function getTeacherForId(teacherId:String) : Teacher {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Teacher;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_TEACHER_FOR_ID;
			stmt.parameters[0] =  teacherId ;
			stmt.execute();
			var teacher:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(teacher!=null) {
				return teacher.getItemAt(0) as Teacher;
			} else {
				return null;
			}
		}
		
		public static function getCourseForId(courseId:String) : Course {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Course;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_COURSE_FOR_ID;
			stmt.parameters[0] =  courseId ;
			stmt.execute();
			var course:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(course!=null) {
				return course.getItemAt(0) as Course;
			} else {
				return null;
			}
		}
		
		public static function getBatchForId(batchId:String) : Batch {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Batch;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_BATCH_FOR_ID;
			stmt.parameters[0] =  batchId ;
			stmt.execute();
			var batch:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(batch!=null) {
				return batch.getItemAt(0) as Batch;
			} else {
				return null;
			}
		}
		
		public static function getBatchList() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_GET_BATCH_LIST;
			stmt.execute();
			var batch:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(batch!=null) {
				trace(batch.length);
			}
			
			return batch;
		}
		
		// Retrieve students with a Select all call
		public static function searchStudents(student:Student):ArrayCollection
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Batch;
			stmt.sqlConnection = sipDb;
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.S_STUDENT;
			stmt.parameters[0] = "%" + student.firstname + "%";
			stmt.parameters[1] = "%" + student.lastname + "%";
			stmt.execute();
			var data:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			return data;
			
		}
		
		public static function getStudentLevelCount() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);

			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			var d:Date = new Date();
			var month = d.month;
			month = month + 1;
			var monthStr = month+"";
			if(month < 10 ) {
				monthStr = "0" + monthStr;
			}
			stmt.text = "SELECT count(level) as studentcount, level from students group by level";
			stmt.execute();
			var activeStudents:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(activeStudents!=null) {
				trace(activeStudents.length);
			}
			
			return activeStudents;
		}
		
		public static function getCourseList() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;

			stmt.text = SQLQueries.S_ALL_COURSES;
			stmt.execute();
			var courses:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(courses!=null) {
				trace(courses.length);
			}
			
			return courses;
		}

		public static function getExpenseList() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_EXPENSES;
			stmt.execute();
			var expenses:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(expenses!=null) {
				trace(expenses.length);
			}
			
			return expenses;
		}
		
		public static function getActiveBatchList() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_BATCH_ALL;
			stmt.execute();
			var courses:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(courses!=null) {
				trace(courses.length);
			}
			
			return courses;
		}
		
		
		public static function getTeacherList() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_GET_TEACHERS;
			stmt.execute();
			var teachers:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(teachers!=null) {
				trace(teachers.length);
			}
			
			return teachers;
		}
		
		

		
		public static function getAllStudents() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.S_STUDENT_ALL_ACTIVE;
			stmt.execute();
			var activeStudents:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(activeStudents!=null) {
				trace(activeStudents.length);
			}
			
			return activeStudents;
		}
		
		public static function getBatchStudentList(batchId:String) : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			//stmt.text = SQLQueries.S_BATCH_STUDENT_LIST;
			stmt.text = SQLQueries.S_ALL_BATCH_STUDENTS;
			
			stmt.parameters[0] = batchId;
			stmt.execute();
			var activeStudents:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(activeStudents!=null) {
				trace(activeStudents.length);
			}
			
			return activeStudents;
		}
		
		public static function getMonthCounts() : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.S_MONTH_COUNTS;
			//mt.parameters[0] = batchId;
			stmt.execute();
			var monthVIews:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(monthVIews!=null) {
				trace(monthVIews.length);
			}
			return monthVIews;
		}
		
		/**
		 * Adds monthly count of students by one 
		 */
		public static function addMonthlyCount(month:String, year:String, level:String) : void {
			
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.S_MONTH_VIEW;
			stmt.parameters[0] = month;
			stmt.parameters[1] = year;
			stmt.parameters[2] = level;
			stmt.execute();
			var monthViews:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(monthViews!=null) {
				if(monthViews.length > 0 ) {
					var viewObj:Object  = monthViews.getItemAt(0);
					var count:Number = viewObj.actual;
					
					var stmt:SQLStatement = new SQLStatement();
					//stmt.itemClass = Student;
					stmt.sqlConnection = sipDb;
					stmt.text = SQLQueries.U_MONTH_VIEW;
					stmt.parameters[0] = count+1;
					stmt.parameters[1] = month;
					stmt.parameters[2] = year;
					stmt.parameters[3] = level;
					
					stmt.execute();
					
				} else  {
					createMonthViewCounts(month,year,level,0,0);
					addMonthlyCount(month,year,level);
				}
			}
		}

		/**
		 * Adds monthly count of students by one 
		 */
		public static function updatePlanCount(month:String, year:String, level:String, planCount:Number) : void {
			
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.S_MONTH_VIEW;
			stmt.parameters[0] = month;
			stmt.parameters[1] = year;
			stmt.parameters[2] = level;
			stmt.execute();
			var monthViews:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(monthViews!=null) {
				if(monthViews.length > 0 ) {
					var viewObj:Object  = monthViews.getItemAt(0);
					var count:Number = viewObj.actual;
					
					var stmt:SQLStatement = new SQLStatement();
					//stmt.itemClass = Student;
					stmt.sqlConnection = sipDb;
					stmt.text = SQLQueries.U_MONTH_VIEW;
					stmt.parameters[0] = planCount;
					stmt.parameters[1] = month;
					stmt.parameters[2] = year;
					stmt.parameters[3] = level;
					
					stmt.execute();
					
				} else  {
					createMonthViewCounts(month,year,level,0,0);
					addMonthlyCount(month,year,level);
				}
			}
		}

		

		public static function createMonthViewCounts(month:String, year:String,level:String, plan:Number, actual:Number) : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			// Retrieve students with a Select all call
			var stmt:SQLStatement = new SQLStatement();
			//stmt.itemClass = Student;
			stmt.sqlConnection = sipDb;
			stmt.text = SQLQueries.I_MONTH_VIEW;
			stmt.parameters[0] = month;
			stmt.parameters[1] = year;
			stmt.parameters[2] = level;
			stmt.parameters[3] = plan;
			stmt.parameters[4] = actual;
			
			
			stmt.execute();
			var monthVIews:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			if(monthVIews!=null) {
				trace(monthVIews.length);
			}
			return monthVIews;
		}

		
		public static function getUpdatedReportView(year:String, level: String) : ArrayCollection {
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("sipdb.db");
			var sipDb:SQLConnection = new SQLConnection();
			sipDb.open(dbFile);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.itemClass = MonthView;
			stmt.sqlConnection = sipDb;
			
			stmt.text = SQLQueries.S_FROM_MONTH_VIEW;
			stmt.parameters[0] =  year ;
			stmt.parameters[1] = level;
			stmt.execute();
			var monthView:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			return monthView;
		}
		

		
	}	
}