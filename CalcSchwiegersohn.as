﻿/* AS3	Copyright 2009 __MyCompanyName__.*/package {		import flash.events.*;	import SchwiegersohnObject;	import flash.display.*;	/**	 *	Class description.	 *	 *	@langversion ActionScript 3.0	 *	@playerversion Flash 9.0	 *	 *	@author Sven Gali	 *	@since  01.02.2009	 */	public class CalcSchwiegersohn extends MovieClip {				//--------------------------------------		// CLASS CONSTANTS		//--------------------------------------				//--------------------------------------		//  CONSTRUCTOR		//--------------------------------------				/**		 *	@Constructor		 */		public function CalcSchwiegersohn (){					}				//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------				private var playList: Array;		private var videoObjects: Array;				//Vater Array als Steuerung		private var v_start_arr: Array;		private var v_alle_arr: Array;		private var v_ende_pos_arr: Array;		private var v_ende_neg_arr: Array;			//Kai		private var kai_alle_arr: Array;		private var kai_ende_pos_arr: Array;		private var kai_ende_neg_arr: Array;				//Nonsens: Mutter und Tocher mit Fkt=Nonsens		private var nonsens_arr: Array;				//Temp und Steuervariablen		private var bewertung_neg: int;		private var bewertung_pos: int;		private var oneVar: Boolean;				private var currentVideoIndex: int;		private var absolutIndex: int;		private var currentVidObj: SchwiegersohnObject;						//--------------------------------------		//  GETTER/SETTERS		//--------------------------------------				//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------						public function calculateClips(xml:XMLList): Array {			playList = new Array ();			videoObjects = new Array ();						v_start_arr = new Array ();			v_alle_arr = new Array ();						v_ende_neg_arr = new Array ();			v_ende_pos_arr = new Array ();								kai_alle_arr = new Array ();			kai_ende_pos_arr = new Array ();			kai_ende_neg_arr = new Array ();			nonsens_arr = new Array ();						bewertung_pos = 0;			bewertung_neg = 0;			oneVar = false;									//Videoobjecte parsen und in Array legen			for (var i:int = 0; i<xml.length(); i++)			{				videoObjects[i] = new SchwiegersohnObject (													  i 																		, xml[i].file.text()															, xml[i].myRole.text()															, xml[i].myCategory.text()														, xml[i].myFunction.text()													, xml[i].myAttribut.text()													, xml[i].myBewertung.text()													, xml[i].myTags													, xml[i].role.text()													, xml[i].category.text()													, xml[i].funktion.text()													, xml[i].attribut.text()													, xml[i].bewertung.text()													, xml[i].tags												);																							if(videoObjects[i].getMyRole == "Heinrich"){					if(videoObjects[i].getMyCategory == "Verabschiedung")					{												if(videoObjects[i].getbewertung == "negativ"){							v_ende_neg_arr.push(videoObjects[i]);						}else{							v_ende_pos_arr.push(videoObjects[i]);						}											}else{						v_alle_arr.push(videoObjects[i]);					}									}				if(videoObjects[i].getMyRole == "Kai"){ 					if(videoObjects[i].getMyCategory == "Verabschiedung"){						if(videoObjects[i].getbewertung == "negativ"){							kai_ende_neg_arr.push(videoObjects[i]);						}else{							kai_ende_pos_arr.push(videoObjects[i]);						}					}else{						kai_alle_arr.push(videoObjects[i]);											}				}								if(videoObjects[i].getMyCategory == "Nonsens")				{					nonsens_arr.push(videoObjects[i]);				}			} 			/** propertyTest **/			trace("v_ende_neg_arr: "+v_ende_neg_arr.length);			trace("v_ende_pos_arr: "+v_ende_pos_arr.length);			trace("v_alle_arr: "+v_alle_arr.length);			trace("kai_ende_neg_arr: "+kai_ende_neg_arr.length);			trace("kai_ende_pos_arr: "+kai_ende_pos_arr.length);			trace("kai_alle_arr: "+kai_alle_arr.length);			trace("nonsens_arr: "+nonsens_arr.length);						trace("Parsen fehlerfrei abgeschlossen!");						/** Intro **/			playList.push("SANY0157.MP4");									/** Meta-Suchloop: Hauptteil **/ 			for (var j:int = 0; j<10; j++){				currentVideoIndex = Math.round((v_alle_arr.length-1)*Math.random());		//Random Frage auswählen				playList.push(v_alle_arr[currentVideoIndex].getUrl);								absolutIndex = checkNachfolger(v_alle_arr[currentVideoIndex]);				//Nachfolger finden								playList.push(kai_alle_arr[absolutIndex].getUrl);								switch(kai_alle_arr[absolutIndex].getbewertung)								//Bewertung gewichten				{					case "positiv": bewertung_pos++;					break;					case "negativ": bewertung_neg++;					break;				}								v_alle_arr.splice(currentVideoIndex,1);										//Gewählte Clips aus Listen löschen				kai_alle_arr.splice(absolutIndex,1);								trace("Bewertung Positiv: "+bewertung_pos);				trace("Bewertung Negativ: "+bewertung_neg);								/** Bewertungsclips integrieren **/ 				if((bewertung_neg == 2) && (bewertung_pos<=bewertung_neg) && (!oneVar))				{					var rand:int = Math.round((nonsens_arr.length-1)*Math.random());					playList.push(nonsens_arr[rand].getUrl);					oneVar = true;				}			}						/** Abschied Bewertung gewichtet **/ 			if(bewertung_pos<=bewertung_neg)			{				//Vater Endclip				playList.push(v_ende_neg_arr[0].getUrl);				//Kai Endclip				playList.push(kai_ende_neg_arr[0].getUrl);			}else{				//Vater Endclip				playList.push(v_ende_pos_arr[0].getUrl);				//Kai Endclip				playList.push(kai_ende_pos_arr[0].getUrl);			}						return playList;		}							private function checkNachfolger (curVid:SchwiegersohnObject): int 		{			var tempObject: Object = new Object ();			tempObject.matchVar = 0;			tempObject.idx = 0;						var _vergl_arr:Array = [];					for (var i:int = 0;  i<kai_alle_arr.length; i++) 			{												kai_alle_arr[i].myMatchVar = 0;												//Matchvariable zurücksetzen								if(kai_alle_arr[i].getMyCategory == curVid.getKategorie)					//Nur die Clips mit Hardfacts				{									if (kai_alle_arr[i].getFunktion == curVid.getMyFunction)				//Rolle und Kategorie checken					{						if (kai_alle_arr[i].getAttribut == curVid.getMyAttribut)						{									for each (var item in kai_alle_arr[i].getTags)					//Tags checken							{									for each (var tag in curVid.getMyTags)								{									if(item == tag) kai_alle_arr[i].myMatchVar++;								}							}						}					}								if( tempObject.matchVar <= kai_alle_arr[i].myMatchVar)					//Vergleichen ob matchVar höher als Vorgänger					{						tempObject.matchVar = kai_alle_arr[i].myMatchVar;						tempObject.idx = i;						_vergl_arr.push(i);					}				}											}			_vergl_arr.reverse();			trace("_Länge Vergleich Array: "+_vergl_arr.length);			if(_vergl_arr.length>2){				//return _vergl_arr[0];				return _vergl_arr[Math.round(1*Math.random())];				}else{				return _vergl_arr[0];			}			}				/*		private function propertyTest ():void {			trace("URL: " + videoObjects[1].getUrl);			trace("myRoll: " + videoObjects[1].getMyRole);			trace("myCategory: " + videoObjects[1].getMyCategory);			trace("myFunction: " + videoObjects[1].getMyFunction);			//trace("myStregth: " + videoObjects[1].getMyStrength);			//trace("mySzenario: " + videoObjects[1].getMySzenario);			trace("myAttribut: " + videoObjects[1].getMyAttribut);			trace("myTags: " + videoObjects[1].getMyTags);			//trace("myPattern: " + videoObjects[1].getMyPattern);			//trace("myStartenabled: " + videoObjects[1].getMyStartEnabled);			trace("Kategorie: " + videoObjects[1].getKategorie);			trace("Funktion: " + videoObjects[1].getFunktion);			trace("Attribut: " + videoObjects[1].getAttribut);			trace("Tags: " + videoObjects[1].getTags);		}		*/	}}