﻿/* AS3	Copyright 2009 Gali.*/package {		import flash.events.*;	import DemoObject;	import Utils;	import flash.display.*;	/**	 *	Class description.	 *	 *	@langversion ActionScript 3.0	 *	@playerversion Flash 9.0	 *	 *	@author Sven Gali	 *	@since  01.02.2009	 */	public class CalcDemo extends MovieClip {				/**		 *	@Constructor		 */		public function CalcDemo (){					}				//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------				private var playList: Array;		private var videoObjects: Array;				// Arrays der Rollen		private var police_arr:Array;		private var demo_arr:Array;				private var currentVideoIndex: int;		private var rand_Start:int;						//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------				public function calculateClips(xml:XMLList): Array {						playList = new Array ();			videoObjects = new Array ();						// Construct Charakter			police_arr = new Array ();			demo_arr = new Array ();						// Construct Motive Arrays			for(var i:int=0; i<5; i++){				police_arr[i] = new Array();				demo_arr[i] = new Array();			}						// Videoobjecte parsen und in Arrays legen			for (var i:int = 0; i<xml.length(); i++)			{				videoObjects[i] = new DemoObject (													  i 																		, xml[i].file.text()															, xml[i].myRole.text()															, xml[i].myCategory.text()												);																				// Motiv-Arrays füllen				if(videoObjects[i].getMyRole == "Polizei"){					if(videoObjects[i].getMyCategory == "Ich_Beduerfnis") police_arr[0].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Selbstverwirklichung") police_arr[1].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Soziale_Motive") police_arr[2].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Sicherheits_Motive") police_arr[3].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Grundbeduerfnis") police_arr[4].push(videoObjects[i]);				} 				if (videoObjects[i].getMyRole == "Demo"){					if(videoObjects[i].getMyCategory == "Ich_Beduerfnis") demo_arr[0].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Selbstverwirklichung") demo_arr[1].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Soziale_Motive") demo_arr[2].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Sicherheits_Motive") demo_arr[3].push(videoObjects[i]);					if(videoObjects[i].getMyCategory == "Grundbeduerfnis") demo_arr[4].push(videoObjects[i]);				}			} 						trace("Polizei: "+police_arr.length);			trace("Demo: "+demo_arr.length);			trace("-------");			trace("Einzelarr_1: "+police_arr[0].length);			trace("Einzelarr_2: "+police_arr[1].length);			trace("Einzelarr_3: "+police_arr[2].length);			trace("Einzelarr_4: "+police_arr[3].length);			trace("Einzelarr_5: "+police_arr[4].length);			/**			* Prozessschleife			*/						for(var i:int=0; i<7; i++){				rand_Start = Utils.randRound(2)+1;				trace(rand_Start);				for (var n:int=rand_Start; n<4; n++){					// Auswahl, Einfügen und Löschen des Demonstranten					currentVideoIndex = Utils.randRound(demo_arr[n].length);					playList.push(demo_arr[n][currentVideoIndex].getUrl);					demo_arr[n].splice(currentVideoIndex,1);										// Auswahl, Einfügen und Löschen des Polices					currentVideoIndex = Utils.randRound(police_arr[n+1].length);					playList.push(police_arr[n+1][currentVideoIndex].getUrl);					police_arr[n+1].splice(currentVideoIndex,1);				}			}			return playList;		}				}}