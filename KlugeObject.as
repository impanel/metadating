/* AS3
	Copyright 2009 __MyCompanyName__.
*/
package {
	
	/**
	 *	Class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author Sven Krome
	 *	@since  01.02.2009
	 */
	public class KlugeObject {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		
		/**
		 *	@Constructor
		 */
		public function KlugeObject(
									  vidID:int
									, myU:String
									, myR:String
									, myC:String
									, myAttr:String									
									, myT:XMLList
									, cat:String
									, attr:String
									, ta:XMLList
													){
			videoID = vidID;
			myURL = myU;
			myRole = myR;
			myCategory = myC;
			myAttribut = myAttr;
			parseMyTags(myT);

			myMatchVar = 0;

			kategorie = cat;
			attribut = attr;											
			parseTags(ta);		
		}
		
		
		//--------------------------------------
		//  PUBLIC AND PRIVATE VARIABLES
		//--------------------------------------
		
		//Eigenschaften
		private var myURL:String;
		private var myCategory:String;
		private var myRole:String;
		private var myAttribut:String;
		private var myTags:Array;
		//Flags
		private var videoID:int;
		public var myMatchVar:int;
		
		//Bedingungen
		private var kategorie:String;
		private var attribut:String;
		private var tags:Array;

		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function get getID(): int {
			return videoID;
		}
		
		public function get getUrl(): String {
			return myURL;
		}
		
		public function get getMyRole(): String {
			return myRole;
		}
		
		public function get getMyCategory(): String {
			return myCategory;
		}
		
		public function get getMyAttribut(): String {
			return myAttribut;
		}
		
		public function get getMyTags(): Array {
			return myTags;
		}
		
		public function get getKategorie(): String {
			return kategorie;
		}

		public function get getAttribut(): String {
			return attribut;
		}
		
		public function get getTags(): Array {
			return tags;
		}
				
		//Flags
	
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------

		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		private function parseMyTags (xml:XMLList) {
			myTags = new Array ();
			for each (var item in xml.tag){
				myTags.push(item);
			}
			if(myTags[0] == "keine") myTags = [];
		}
		
		private function parseTags (xml:XMLList) {
			tags = new Array ();
			for each (var item in xml.tag){
				tags.push(item);
			}
			if(tags[0] == "keine") tags = [];
		}
	}
}
	