package com.genius.model
{
	import mx.collections.ArrayCollection;
	

	[Bindable]
	public class ApplicationModel
	{
		
		
		static private var _instance:ApplicationModel;
		
		public function ApplicationModel(e:SingletonEnforcer)
		{
		}
		
		static public function get instance():ApplicationModel
		{
			if(!_instance)
				_instance = new ApplicationModel(new SingletonEnforcer);
			return _instance;
		}

		public var monthList:ArrayCollection = new ArrayCollection([
			{name:"JAN", id:"01"},
			{name:"FEB", id:"01"},
			{name:"MAR", id:"02"},
			{name:"APR", id:"03"},
			{name:"JUN", id:"04"},
			{name:"JUL", id:"05"},
			{name:"AUG", id:"06"},
			{name:"SEP", id:"07"},
			{name:"OCT", id:"08"},
			{name:"NOV", id:"09"},
			{name:"DEC", id:"10"}]);
			
			
		public var dashBoardStat:DashBoardStat = null;
		
		public var students:ArrayCollection;
		public var expenseList:ArrayCollection;
		public var courseList:ArrayCollection;
		public var teacherList:ArrayCollection;
		public var batchList:ArrayCollection;
		public var monthlyCounts:ArrayCollection;
		public var branchId:String = "1904";
		
		public var currentStudent:Student;
		public var selectedBatch:Batch;
		public var selectedTeacher:Teacher;
		public var selectedCourse:Course;
		
		public function getCourseIdFromName(courseName:String):String {
			var idString:String = "";
			for(var i:int=0; i<courseList.length; i++ ) {
				var o:Object = courseList.getItemAt(i);
				if(o.coursename==courseName) {
					idString=o.id;
					break;
				}
			}
			return idString;
		}

		public function getCourseNameFromId(courseId:String):String {
			var name:String = "";
			for(var i:int=0; i<courseList.length; i++ ) {
				var o:Object = courseList.getItemAt(i);
				if(o.id==courseId) {
					name=o.coursename;
					break;
				}
			}
			return name;
		}
		

	}
	
}
class SingletonEnforcer{}