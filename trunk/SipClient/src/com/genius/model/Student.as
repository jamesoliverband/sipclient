package com.genius.model
{
	
	// This class is used by the SampleDatabase.mxml view which shows how to use a local SQLite database
	
	[Bindable]
	public class Student
	{
		public var id:String;
		public var firstname:String="";
		public var middlename:String="";;
		public var lastname:String="";
		public var level:String="";
		public var dob:String="";
		public var enrolldate:String="";
		public var currentlevel:String="";
		public var schoolname:String="";
		public var contactnumber1:String="";
		public var contactnumber2:String="";
		public var contactnumber3:String="";
		public var activestatus:String = "Y";
		
		public function get fullName():String
		{
			return firstname+ " " + lastname;
		}
		
	}
	
	
}