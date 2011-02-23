package com.genius.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Batch {
		public var id:String;
		public var teachername:String;
		public var coursename:String;
		public var startdate:String;
		public var enddate:String;
		public var days:String;
		public var time:String;
		public var runningstatus:String = "Y";
		
		public var studentList:ArrayCollection;
	}
}