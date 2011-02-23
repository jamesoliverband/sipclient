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
		
		
		
		

	}
	
}
class SingletonEnforcer{}