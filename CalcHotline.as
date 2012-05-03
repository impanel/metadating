﻿/* AS3	Copyright 2009 Gali.*/package {		import flash.events.*;	import HotlineObject;	import Utils;	import flash.display.*;	/**	 *	Class description.	 *	 *	@langversion ActionScript 3.0	 *	@playerversion Flash 9.0	 *	 *	@author Sven Gali	 *	@since  01.02.2009	 */	public class CalcHotline extends MovieClip {				/**		 *	@Constructor		 */		public function CalcHotline (){					}				//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------				private var playList: Array;		private var videoObjects: Array;				//Pool Arrays der Rollen		private var supporter_arr: Array;		private var supporter_esc_arr: Array;		private var supporter_kon_arr: Array;		private var supporter_fin_arr: Array;				private var oma_arr: Array;		private var oma_esc_arr: Array;		private var oma_kon_arr: Array;		private var oma_fin_arr: Array;				private var techi_arr: Array;		private var techi_esc_arr: Array;		private var techi_kon_arr: Array;		private var techi_fin_arr: Array;				private var labile_arr: Array;		private var labile_esc_arr: Array;		private var labile_kon_arr: Array;		private var labile_fin_arr: Array;				// Pools Steurung		private var intros_mt_arr:Array;		private var intros_chr_arr:Array;		private var outros_arr:Array;		private var agent_arr:Array;		private var agent_esc_arr:Array;		private var agent_kon_arr:Array;		private var agent_fin_arr:Array;				private var currentVideoIndex: int;		private var absolutIndex: int;		private var currentVidObj: HotlineObject;						//--------------------------------------		//  GETTER/SETTERS		//--------------------------------------				//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------						public function calculateClips(xml:XMLList): Array {						playList = new Array ();			videoObjects = new Array ();						// Pools Charakter			supporter_arr = new Array ();			supporter_esc_arr = new Array ();			supporter_kon_arr = new Array ();			supporter_fin_arr = new Array ();						oma_arr = new Array ();			oma_esc_arr = new Array ();			oma_kon_arr = new Array ();			oma_fin_arr = new Array ();									techi_arr = new Array ();			techi_esc_arr = new Array ();			techi_kon_arr = new Array ();			techi_fin_arr = new Array ();			labile_arr = new Array ();			labile_esc_arr = new Array ();			labile_kon_arr = new Array ();			labile_fin_arr = new Array ();						// Pools Steurung			intros_mt_arr = new Array ();			intros_chr_arr = new Array ();			outros_arr = new Array ();						agent_arr = new Array ();			agent_esc_arr = new Array ();			agent_kon_arr = new Array ();			agent_fin_arr = new Array ();						//Videoobjecte parsen und in Array legen			for (var i:int = 0; i<xml.length(); i++)			{				videoObjects[i] = new HotlineObject (													  i 																		, xml[i].file.text()															, xml[i].myRole.text()															, xml[i].myCategory.text()													, xml[i].myEskalation.text()													, xml[i].myDialog													, xml[i].myTags													, xml[i].dialog													, xml[i].tags												);								// Füllen des Eröffnungsarrays				if(videoObjects[i].getMyCategory == "Eroeffnung"){					if(videoObjects[i].getMyRole == "Mitarbeiter"){						intros_mt_arr.push(videoObjects[i]);					}else{						intros_chr_arr.push(videoObjects[i]);					}				}												// Füllen der SUPPORTER-Arrays				if(videoObjects[i].getMyRole == "Mitarbeiter" && videoObjects[i].getMyCategory == "Dialog"){					if(videoObjects[i].getMyEskalation == "Nein"){						supporter_arr.push(videoObjects[i]);					}else{						supporter_esc_arr.push(videoObjects[i]);					}				}				if(videoObjects[i].getMyRole == "Mitarbeiter" && videoObjects[i].getMyCategory == "Konklusion") supporter_kon_arr.push(videoObjects[i]);				if(videoObjects[i].getMyRole == "Mitarbeiter" && videoObjects[i].getMyCategory == "Ende") supporter_fin_arr.push(videoObjects[i]);								// Füllen der OMA-Arrays				if(videoObjects[i].getMyRole == "Oma" && videoObjects[i].getMyCategory == "Dialog"){					if(videoObjects[i].getMyEskalation == "Nein"){						oma_arr.push(videoObjects[i]);					}else{						oma_esc_arr.push(videoObjects[i]);					}				}				if(videoObjects[i].getMyRole == "Oma" && videoObjects[i].getMyCategory == "Konklusion") oma_kon_arr.push(videoObjects[i]);				if(videoObjects[i].getMyRole == "Oma" && videoObjects[i].getMyCategory == "Ende") oma_fin_arr.push(videoObjects[i]);								// Füllen der TEKKI-Arrays				if(videoObjects[i].getMyRole == "Tekki" && videoObjects[i].getMyCategory == "Dialog"){					if(videoObjects[i].getMyEskalation == "Nein"){						techi_arr.push(videoObjects[i]);					}else{						techi_esc_arr.push(videoObjects[i]);					}				}				if(videoObjects[i].getMyRole == "Tekki" && videoObjects[i].getMyCategory == "Konklusion") techi_kon_arr.push(videoObjects[i]);				if(videoObjects[i].getMyRole == "Tekki" && videoObjects[i].getMyCategory == "Ende") techi_fin_arr.push(videoObjects[i]);								// Füllen der LABILE-Arrays				if(videoObjects[i].getMyRole == "Labile" && videoObjects[i].getMyCategory == "Dialog"){					if(videoObjects[i].getMyEskalation == "Nein"){						labile_arr.push(videoObjects[i]);					}else{						labile_esc_arr.push(videoObjects[i]);					}				}				if(videoObjects[i].getMyRole == "Labile" && videoObjects[i].getMyCategory == "Konklusion") labile_kon_arr.push(videoObjects[i]);				if(videoObjects[i].getMyRole == "Labile" && videoObjects[i].getMyCategory == "Ende") labile_fin_arr.push(videoObjects[i]);			/*				trace("Type der Clips: "					  +videoObjects[i].getMyRole 					  +" => "					  +videoObjects[i].getMyCategory					  +" => "					  +videoObjects[i].getMyEskalation);			*/			}						// Trace Pools			trace("supporter_arr: "+supporter_arr.length);			trace("supporter_esc_arr: "+supporter_esc_arr.length);			trace("supporter_kon_arr: "+supporter_kon_arr.length);			trace("supporter_fin_arr: "+supporter_fin_arr.length);			trace("--------------");			trace("oma_arr: "+oma_arr.length);			trace("oma_esc_arr: "+oma_esc_arr.length);			trace("oma_kon_arr: "+oma_kon_arr.length);			trace("oma_fin_arr: "+oma_fin_arr.length);			trace("--------------");			trace("techi_arr: "+techi_arr.length);			trace("techi_esc_arr: "+techi_esc_arr.length);			trace("techi_kon_arr: "+techi_kon_arr.length);			trace("techi_fin_arr: "+techi_fin_arr.length);			trace("--------------");			trace("labile_arr: "+labile_arr.length);			trace("labile_esc_arr: "+labile_esc_arr.length);			trace("labile_kon_arr: "+labile_kon_arr.length);			trace("labile_fin_arr: "+labile_fin_arr.length);			trace("--------------");			//Trace Pools Steuerung			trace("intros_mt_arr: "+intros_mt_arr.length);			trace("intros_chr_arr: "+intros_chr_arr.length);									/** 			* Intro *			**/			//Eröffnung supporter			//traceUrls(intros_chr_arr);			playList.push(intros_mt_arr[Utils.randRound(intros_mt_arr.length)].getUrl);						//Eröffnung Charakter			currentVideoIndex = Utils.randRound(intros_chr_arr.length)			playList.push(intros_chr_arr[currentVideoIndex].getUrl);			currentVidObj = intros_chr_arr[currentVideoIndex];									//Bestimmen des Pools			switch(intros_chr_arr[currentVideoIndex].getMyRole){				case "Oma": 					agent_arr = oma_arr;					agent_esc_arr = oma_esc_arr;					agent_kon_arr = oma_kon_arr;					agent_fin_arr = oma_fin_arr;				break;				case "Tekki": 					agent_arr = techi_arr;					agent_esc_arr = techi_esc_arr;					agent_kon_arr = techi_kon_arr;					agent_fin_arr = techi_fin_arr;				break;				case "Labile": 					agent_arr = labile_arr;					agent_esc_arr = labile_esc_arr;					agent_kon_arr = labile_kon_arr;					agent_fin_arr = labile_fin_arr;				break;			}			trace("Gewählter Charakter: "+intros_chr_arr[currentVideoIndex].getMyRole);						/** 			* Hauptteil *			**/						// Metasuchlauf			for (var j:int = 0; j<5; j++){								//Nachfolger suchen für Anrufer				absolutIndex = checkNachfolger(currentVidObj, supporter_arr);				playList.push(supporter_arr[absolutIndex].getUrl);				currentVidObj = supporter_arr[absolutIndex];				supporter_arr.splice(absolutIndex,1);				//Nachfolger für Supporter				absolutIndex = checkNachfolger(currentVidObj, agent_arr);				playList.push(agent_arr[absolutIndex].getUrl);				currentVidObj = agent_arr[absolutIndex];				agent_arr.splice(absolutIndex,1);			}			//Per Zufall welcher Character die Eskalation beginnt			///////////// TODO //////////////////////////////////// Schauen ob die Einheiten auch abhängig voneinander sind// EndeClips Array mit einbauen...			if(Math.random()<.5){				absolutIndex = checkNachfolger(currentVidObj, supporter_arr);				playList.push(supporter_arr[absolutIndex].getUrl);				currentVidObj = supporter_arr[absolutIndex];								// Eskalation				currentVideoIndex = Utils.randRound(agent_esc_arr.length);				playList.push(agent_esc_arr[currentVideoIndex].getUrl);				currentVidObj = agent_esc_arr[currentVideoIndex];				absolutIndex = checkNachfolger(currentVidObj, supporter_esc_arr);				playList.push(supporter_esc_arr[absolutIndex].getUrl);				currentVidObj = supporter_esc_arr[absolutIndex];								// Konklusion				currentVideoIndex = Utils.randRound(agent_kon_arr.length);				playList.push(agent_kon_arr[currentVideoIndex].getUrl);				currentVidObj = agent_kon_arr[currentVideoIndex];				absolutIndex = checkNachfolger(currentVidObj, supporter_kon_arr);				playList.push(supporter_kon_arr[absolutIndex].getUrl);				currentVidObj = supporter_kon_arr[absolutIndex];								// Abschied				currentVideoIndex = Utils.randRound(agent_fin_arr.length);				playList.push(agent_fin_arr[currentVideoIndex].getUrl);				currentVidObj = agent_fin_arr[currentVideoIndex];				absolutIndex = checkNachfolger(currentVidObj, supporter_fin_arr);				playList.push(supporter_fin_arr[absolutIndex].getUrl);				currentVidObj = supporter_fin_arr[absolutIndex];							}else{				// Eskalation				currentVideoIndex = Utils.randRound(supporter_esc_arr.length);				playList.push(supporter_esc_arr[currentVideoIndex].getUrl);				currentVidObj = supporter_esc_arr[currentVideoIndex];								absolutIndex = checkNachfolger(currentVidObj, agent_esc_arr);				playList.push(agent_esc_arr[absolutIndex].getUrl);				currentVidObj = agent_esc_arr[absolutIndex];							// Konklusion				currentVideoIndex = Utils.randRound(supporter_kon_arr.length);				playList.push(supporter_kon_arr[currentVideoIndex].getUrl);				currentVidObj = supporter_kon_arr[currentVideoIndex];								absolutIndex = checkNachfolger(currentVidObj, agent_kon_arr);				playList.push(agent_kon_arr[absolutIndex].getUrl);				currentVidObj = agent_kon_arr[absolutIndex];								// Abschied				currentVideoIndex = Utils.randRound(supporter_fin_arr.length);				playList.push(supporter_fin_arr[currentVideoIndex].getUrl);				currentVidObj = supporter_fin_arr[currentVideoIndex];				absolutIndex = checkNachfolger(currentVidObj, agent_fin_arr);				playList.push(agent_fin_arr[absolutIndex].getUrl);				currentVidObj = agent_fin_arr[absolutIndex];			}						/** 			* Abschied 			*/ /*			currentVideoIndex = Utils.randRound(supporter_fin_arr.length);			playList.push(supporter_fin_arr[currentVideoIndex].getUrl);			currentVidObj = supporter_fin_arr[currentVideoIndex];			absolutIndex = checkNachfolger(currentVidObj, agent_fin_arr);			playList.push(agent_fin_arr[absolutIndex].getUrl);			currentVidObj = agent_fin_arr[absolutIndex];						/**			* Rückgabe 			*/			trace("Ausgabe: "+playList);									return playList;		}							/**		* Nachfolger Funktionen		*/		private function checkNachfolger (curVid:HotlineObject, _arr:Array): int 		{			var _temp_arr:Array = [];			for (var i:int = 0;  i<(_arr.length-1); i++){				_arr[i].myMatchVar = 0;								//Ähnlichkeit checken				for each (var item in _arr[i].getDialogs) {						for each (var tag in curVid.getMyDialogs){						if(item == tag) _arr[i].myMatchVar++;					}				}								//Ähnlichkeit checken				for each (var item in _arr[i].getAttributes) {						for each (var tag in curVid.getMyAttributes){						if(item == tag) _arr[i].myMatchVar++;					}				}								if(_arr[i].myMatchVar >= 2){					_temp_arr.push(i);				}							}			trace("----------------->>>>> ErgebnisArray: "+_temp_arr.length);			if(_temp_arr.length>0){				return _temp_arr[Utils.randRound(_temp_arr.length)];			}else{				return Utils.randRound(_arr.length);			}		}				private function traceUrls(_arr):void{ 			for(var i:int = 0; i<_arr.length; i++){				trace("Clip"+i+" => "+_arr[i].getUrl); 			}		}	}}