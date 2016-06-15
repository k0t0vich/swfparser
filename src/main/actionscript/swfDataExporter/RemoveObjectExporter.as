package swfDataExporter 
{
	import fastByteArray.FastByteArray;
	import flash.utils.ByteArray;
	import swfdata.dataTags.SwfPackerTag;
	import swfdata.dataTags.SwfPackerTagRemoveObject;
	import swfDataExporter.ExporerTypes;

	public class RemoveObjectExporter extends SwfPackerTagExporter
	{
		
		public function RemoveObjectExporter() 
		{
			super(ExporerTypes.REMOVE_OBJECT);
		}
		
		override public function exportTag(tag:SwfPackerTag, output:FastByteArray):void 
		{
			super.exportTag(tag, output);
			
			var tagAsRemoveObject:SwfPackerTagRemoveObject = tag as SwfPackerTagRemoveObject;
			
			if (tagAsRemoveObject.depth > 32767 || tagAsRemoveObject.depth < 0)
				throw new Error("out of range");
			
			output.writeInt16(tagAsRemoveObject.depth);
			output.writeInt16(tagAsRemoveObject.characterId);
		}
		
		override public function importTag(tag:SwfPackerTag, input:FastByteArray):void 
		{
			super.importTag(tag, input);
			
			var tagAsRemoveObject:SwfPackerTagRemoveObject = tag as SwfPackerTagRemoveObject;
			
			tagAsRemoveObject.depth = input.readInt16();
			tagAsRemoveObject.characterId = input.readInt16();
		}
	}

}