package com.genius.model
{
	import mx.collections.ArrayCollection;
	
	import com.genius.core.DataManager;
	
	[Bindable]
	public class DashBoardStat
	{
		
		public function DashBoardStat()
		{
			
		}
		
		public function refreshDashBoradData ():void {
			var students:ArrayCollection = DataManager.getAllStudents()
			totalStudentCount = students.length;
			var i:Number = 0;
			for ( i=0; i< totalStudentCount; i++ ) {
				var currStudent:Student = students.getItemAt(i) as Student;
				if(currStudent.activestatus == "Y") {
					activeStudentCount++;
				}
			}
			currentMonthBdayStudents = DataManager.getCurrentMonthBirdays();
			studentLevelData = DataManager.getStudentLevelCount();
			
		} 
		
		public var totalStudentCount:Number = 0;
		public var activeStudentCount:Number = 0;
		public var dropStudentCount:Number = 0;
		public var studentLevelData:ArrayCollection;
		public var currentMonthBdayStudents:ArrayCollection;
		
	}
}