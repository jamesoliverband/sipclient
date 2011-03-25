package com.genius.model
{
	public class SQLQueries
	{
		public function SQLQueries()
		{
		}
		
		public static var C_STUDENT:String = "CREATE TABLE IF NOT EXISTS students ( id TEXT PRIMARY KEY, firstname TEXT, middlename TEXT, lastname TEXT, dob TEXT, enrolldate TEXT, schoolname TEXT, contactnumber1 TEXT, contactnumber2 TEXT,contactnumber3 TEXT, level TEXT, currentlevel Text, activestatus Text )";
		public static var I_STUDENT:String = "INSERT into students (id, firstname,middlename,lastname,dob,enrolldate,level,contactnumber1,contactnumber2,contactnumber3,schoolname,activestatus) values(?,?,?,?,?,?,?,?,?,?,?,'Y')";
		
		public static var U_STUDENT:String = "Update students set firstname = ? , middlename = ? , lastname = ?, dob = ?, contactnumber1 = ?, contactnumber2 = ?, contactnumber3 = ?, schoolname = ? where id = ?";
		//public static var U_STUDENT:String = "Update students set firstname = ? where id = ?";
		public static var S_STUDENT_ALL_ACTIVE:String = "Select * from Students where activestatus='Y'";
		public static var S_STUDENT_LEVEL_COUNT:String = "SELECT count(currentlevel) as studentcount, currentlevel as level from students group by currentlevel where activestatus='Y'";
		public static var S_STUDENT_CUR_MONTH_BDAY_1:String = "SELECT firstname, currentlevel, dob from students where dob like '%-";
		public static var S_STUDENT_CUR_MONTH_BDAY_2:String = "-%'";
		//public static var S_STUDENT_ALL_ACTIVE:String = "Select * from Students";
		public static var U_STUDENT_CURRENT_LEVEL:String = "Update students set currentlevel = ? where id= ?";
		public static var U_STUDENT_MARK_DROPED:String = "Update students set activestatus = 'N' where id= ?";
		
		
		public static var S_STUDENT:String = "SELECT * from students where firstName like ? and lastName like ?";

		public static var S_STUDENT_FOR_ID:String = "SELECT * from students where id = ?";
		public static var C_BATCH:String = "CREATE TABLE IF NOT EXISTS batch ( id TEXT PRIMARY KEY, teachername TEXT, coursename TEXT, startdate TEXT, enddate TEXT, days TEXT, time TEXT, runningstatus TEXT )";
		public static var I_BATCH:String = "INSERT into batch (id, teachername,coursename,startdate,enddate,days,time,runningstatus) values(?,?,?,?,?,?,?,?)";
		public static var S_BATCH_ALL:String = "Select b.id as id, b.teachername as teachername, b.coursename as coursename, count(sb.id) as count from batch b left outer join student_batch sb on b.id = sb.batchid where b.runningstatus='Y' group by b.id";
		public static var S_BATCH:String = "Select * from batch where id = ?";
		public static var U_MARK_BATCH_COMPLETE:String = "Update batch set runningstatus='N' where id = ?";
		
		

		
		public static var C_STD_BATCH:String = "CREATE TABLE IF NOT EXISTS student_batch ( id INTEGER PRIMARY KEY AUTOINCREMENT, studentid TEXT, batchid TEXT, fees INTEGER, amountpaid, discount INTEGER, modifieddate TEXT)";
		public static var S_ALL_BATCH_STUDENTS:String = "select s.id,s.firstname, s.lastname from student inner join student_batch sb on s.id = sb.studentid where sb.batchid = ?"
		public static var S_ELIGIBLE_STUDENTS_FOR_BATCH:String = "select s.id, s.firstname, s.lastname from student where level = ?";
		public static var I_STUDENT_BATCH:String = "INSERT into student_batch (studentid,batchid, fees, amountpaid, discount, modifieddate) values(?,?,?,?,?,?)";
		public static var S_BATCH_STUDENT_LIST = "select * from students where id in (select studentid from student_batch where batchid = ? )"; 
		public static var U_BATCH:String = "update batch set teachername=?, coursename=?, startdate=?, enddate=?, days=? , time =? where id=?";
		public static var S_BATCH_FOR_ID:String = "SELECT * from batch where id = ?";
		public static var S_GET_BATCH_LIST:String = "select * from batch";
			
		
		public static var C_MONTH_VIEW:String = "CREATE TABLE IF NOT EXISTS month_view ( id INTEGER PRIMARY KEY AUTOINCREMENT, month TEXT, year TEXT, level Text, plan INTEGER, actual INTEGER)";
		public static var I_MONTH_VIEW:String = "INSERT into month_view (month, year, level, plan, actual) values(?,?,?,?,?)";
		public static var S_MONTH_VIEW:String = "select * from month_view where month=? and year=? and level=?";
		public static var U_MONTH_VIEW:String = "update month_view set actual = ? where month=? and year=? and level=?";
		public static var U_MONTH_VIEW_PLAN:String = "update month_view set plan = ? where month=? and year=? and level=?";
		public static var S_MONTH_COUNTS:String = "select month, year, level, plan, actual from month_view";
		
		
		public static var C_COURSE:String = "CREATE TABLE IF NOT EXISTS course ( id TEXT PRIMARY KEY, coursename TEXT, description TEXT)";
		public static var S_ALL_COURSES:String = "select * from course order by id";
		public static var S_COURSE:String = "select * from course where id=?";
		public static var I_NEW_COURSES:String = "INSERT into course (id, coursename, description) values(?,?,?)";
		public static var U_COURSE:String = "update course set coursename=?, description=? where id=?";
		public static var S_COURSE_FOR_ID:String = "SELECT * from course where id = ?";
		
		public static var C_TEACHER:String = "CREATE TABLE IF NOT EXISTS teacher ( id INTEGER PRIMARY KEY AUTOINCREMENT, teachername TEXT, dob TEXT, qualification TEXT, address TEXT, experience TEXT, mobile TEXT)";
		public static var S_GET_TEACHERS:String = "select * from teacher";
		public static var I_NEW_TEACHER:String = "INSERT into teacher (teachername, dob, qualification, address, experience, mobile) values(?,?,?,?,?,?)";
		public static var U_TEACHER:String = "update teacher set teachername=?, dob=?, qualification=?, address=?, experience=? , mobile =? where id=?";
		public static var S_TEACHER_FOR_ID:String = "SELECT * from teacher where id = ?";


		public static var C_STD_FEES:String = "CREATE TABLE IF NOT EXISTS student_fees ( id INTEGER PRIMARY KEY AUTOINCREMENT, studentid Text, cousename Text, amount FLOAT, discount FLOAT, paymentdate TEXT, remarks Text)";
		public static var S_STD_FEES:String = "select * from student_fees where studentid=?";
		public static var I_STD_FEES:String = "INSERT into student_fees (studentid, coursename, amount, discount, paymentdate) values(?,?,?,?,?)";
		

		public static var C_EXPENSES:String = "CREATE TABLE IF NOT EXISTS expenses ( id INTEGER PRIMARY KEY AUTOINCREMENT, expensehead Text, amount FLOAT,  expensedate TEXT, remarks Text)";
		public static var S_EXPENSES:String = "select * from expenses";
		public static var I_NEW_EXPENSE:String = "INSERT into expenses (expensehead, amount, expensedate, remarks) values(?,?,?,?)";

		
		public static var S_FROM_MONTH_VIEW:String = "SELECT * from month_view where year = ? and level = ?";
		
		//public static var U_TEACHER:String = "update teacher set teachername=? where id=?";

		
		
		
		
	}
}