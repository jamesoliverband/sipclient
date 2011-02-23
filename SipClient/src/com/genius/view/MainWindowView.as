package com.genius.view
{
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.ViewStack;
	import mx.core.FlexGlobals;
	import mx.events.ResizeEvent;
	import mx.managers.CursorManager;
	
	import spark.components.Application;
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.TitleWindow;
	import spark.primitives.BitmapImage;
	import spark.primitives.Rect;
	
	/**
	 * Main Window View Class. This is extension of TitleWindow, with few customizations
	 * as per applications requirement. 
	 *
	 * @author ariel.gimenez
	 * 
	 */	
	
	/**
	 * We declare our own styles for customize look and feel
	 */
	[Style(name="titleBarBackgroundColor", type="uint", format="Color",inherit="no")]
	/**
	 * We redeclare the cornerRadius style and eliminate the attribute "theme=spark" to supress the css warning
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no")]
	/**
	 * We redeclare the borderColor style and eliminate the attribute "theme=spark" to supress the css warning
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")]
	
	[Style(name="borderAlpha", type="Number", inherit="no")]
	
	public class MainWindowView extends TitleWindow
	{
		[SkinPart(required="false")]
		public var placeholderGroup:Group;
		
		[SkinPart(required="false")]
		public var minimizeButton:Button;
		
		[SkinPart(required="false")]
		public var titleLabel:Label;
		
		[SkinPart(required="false")]
		public var resizeBar:Group;
		
		[SkinPart(required="false")]
		public var resizeBarImage:BitmapImage;
		
		
		//----------------------------------------------------------------
		//	Override methods
		//----------------------------------------------------------------
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if(instance == minimizeButton)
			{
				minimizeButton.addEventListener(MouseEvent.CLICK, minimizeHandler);
				
			}
			if(instance == closeButton)
			{
				closeButton.addEventListener(MouseEvent.CLICK, closeHandler);
			}
			if(instance == this.moveArea)
			{
				this.moveArea.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			
			if(instance == minimizeButton)
			{
				minimizeButton.removeEventListener(MouseEvent.CLICK, minimizeHandler);
			}
			if(instance == closeButton)
			{
				closeButton.removeEventListener(MouseEvent.CLICK, closeHandler);
			}
			if(instance == this.moveArea)
			{
				this.moveArea.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}

		}
		
		
		//----------------------------------------------------------------
		//	Listeners
		//----------------------------------------------------------------
		
		
		protected function mouseDownHandler(e:MouseEvent):void
		{
			stage.nativeWindow.startMove();
		}
		
		protected function minimizeHandler(e:MouseEvent):void
		{
			stage.nativeWindow.minimize();			
		}
		
		protected function closeHandler(e:MouseEvent):void
		{
			stage.nativeWindow.close();		
		}
		
	}
}