﻿/* AS3	Copyright 2009 __MyCompanyName__.*/package {		/**	 *	Class description.	 *	 *	@langversion ActionScript 3.0	 *	@playerversion Flash 9.0	 *	 *	@author Sven Krome	 *	@since  01.02.2009	 */	public class AstroObject {				/**		 *	@Constructor		 */		public function AstroObject(									  vidID:int									, myU:String									, myR:String									, myC:String									, myA:String									, myT:String													){			videoID = vidID;			myURL = myU;			myRole = myR;			myCategory = myC;			myAttribute = myA;			myThema = myT;		}				//--------------------------------------		//  PUBLIC AND PRIVATE VARIABLES		//--------------------------------------				//Eigenschaften		private var videoID:int;		private var myURL:String;		private var myCategory:String;		private var myRole:String;		private var myAttribute:String;		private var myThema:String;		//--------------------------------------		//  GETTER/SETTERS		//--------------------------------------				public function get getID(): int {			return videoID;		}				public function get getUrl(): String {			return myURL;		}				public function get getMyRole(): String {			return myRole;		}				public function get getMyCategory(): String {			return myCategory;		}				public function get getMyAttribute(): String {			return myAttribute;		}				public function get getThema(): String {			return myThema;		}	}}