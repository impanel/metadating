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
	public class SchwiegersohnObject {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		
		/**
		 *	@Constructor
		 */
		public function SchwiegersohnObject(
									  vidID:int
									, myU:String
									, myR:String
									, myC:String
									, myF:String
									, myAttr:String
									, myBew:String
									, myT:XMLList
									, ro:String
									, cat:String
									, fu:String
									, attr:String
									, bew:String
									, ta:XMLList
													){
			videoID = vidID;
			myURL = myU;
			myRole = myR;
			myCategory = myC;
			myFunction = myF;
			myAttribut = myAttr;
			myBewertung = myBew;
			parseMyTags(myT);
			
			myMatchVar = 0;
			
			rolle = ro;
			kategorie = cat;
			funktion = fu;											
			attribut = attr;
			bewertung = bew;
			parseTags(ta);
		
		}
		
		//--------------------------------------
		//  PUBLIC AND PRIVATE VARIABLES
		//--------------------------------------
		
		//Eigenschaften
		private var myURL:String;
		private var myCategory:String;
		private var myRole:String;
		private var myFunction:String;
		private var myAttribut:String;
		private var myBewertung:String;
		private var myTags:Array;
		//Flags
		private var videoID:int;
		public var myMatchVar:int;
		
		//Bedingungen
		private var rolle:String;
		private var kategorie:String;
		private var funktion:String;
		private var attribut:String;
		private var bewertung:String;
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
		
		public function get getMyFunction(): String {
			return myFunction;
		}
		
		public function get getMyAttribut(): String {
			return myAttribut;
		}
		
		public function get getMyBewertung(): String {
			return myBewertung;
		}
		
		public function get getMyTags(): Array {
			return myTags;
		}
		
		public function get getRolle(): String {
			return rolle;
		}
		
		public function get getKategorie(): String {
			return kategorie;
		}
		
		public function get getFunktion(): String {
			return funktion;
		}
		
		public function get getAttribut(): String {
			return attribut;
		}
		
		public function get getbewertung(): String {
			return bewertung;
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
		}
		
		private function parseTags (xml:XMLList) {
			tags = new Array ();
			for each (var item in xml.tag){
				tags.push(item);
			}
		}
	}
}
