package appSource
{
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	
	public class AppImage extends TextArea
	{
		public var propertyArray:Array = new Array();
		public var serviceOutputBinding:String = "";
		
		public function AppImage(displayName:String)
		{
			super();//TODO: implement function
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.enabled = false;
			
			propertyArray[0] = "Binding";
			var serviceOutputCombo:ComboBox = new ComboBox();
			serviceOutputCombo.dataProvider = AppViewManager.serviceOutputs;			
			propertyArray[1] = serviceOutputCombo;
			
			propertyArray[2] = "Width";
			var textInputWidth:TextInput = new TextInput(); 
			propertyArray[3] = textInputWidth;
			
			propertyArray[4] = "Height";
			var textInputHeight:TextInput = new TextInput(); 
			propertyArray[5] = textInputHeight;
			
			propertyArray[6] = "Name";
			var textInputName:TextInput = new TextInput(); 
			propertyArray[7] = textInputName;
			
			var displayer:Displayer = new Displayer(displayName);
			AppViewManager.treeData.addItem(displayer);
		
			this.width = 150;
			this.height = 150;
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			this.startDrag();
			var propertyContainer:VBox = this.parentApplication.mashupViews.getChildByName("appViewer").propertyContainer;
			propertyContainer.removeAllChildren();
			for(var i:int = 0; i<propertyArray.length/2; i++)
			{
				var propertyName:Label = new Label();
				propertyName.text = propertyArray[2*i];
				propertyContainer.addChild(propertyName);
				propertyContainer.addChild(propertyArray[2*i+1]);
			}
			
			var setBtn:Button = new Button();
			setBtn.label = "Set";
			setBtn.addEventListener(MouseEvent.CLICK, setBinding);
			propertyContainer.addChild(setBtn);
			
			var deleteBtn:Button = new Button();
			deleteBtn.label = "Delete";
			deleteBtn.addEventListener(MouseEvent.CLICK, deleteControl);
			propertyContainer.addChild(deleteBtn);
			
			/* highlight this control.*/
			if(AppViewManager.selectedControl != null) {
				AppViewManager.selectedControl.opaqueBackground = 0xFFFFFF;
			}
			this.opaqueBackground = 0xEE0000;
			AppViewManager.selectedControl = this;
		}
		
		protected function setBinding(event:MouseEvent):void
		{
			if(propertyArray[3].text != "")
				this.width = parseInt(propertyArray[3].text);
			if(propertyArray[5].text != "")
				this.height = parseInt(propertyArray[5].text);
			this.name = propertyArray[7].text;
			this.serviceOutputBinding = (propertyArray[1] as ComboBox).value.toString();
		}
		
		protected function deleteControl(event:MouseEvent):void
		{
			this.visible = false;
		}
		
		protected function mouseUpHandler(event:MouseEvent):void 
		{
			AppViewManager.mouseUpOperation(this);
		}

	}
}