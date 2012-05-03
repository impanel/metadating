﻿////////////////*TO DO:- blacklist vorangegangenes Thema damit der Brückenschlag es nicht auswählt (fast hinfällig bei der vorhandenen Mehrfachvertaggung)- vielleicht Tagregeln ändern wenn die Gruppe entscheidetemail dazu: Wie habt ihr euch das mit der Mehrfachvertaggung dann vorgestellt. Wenn zum Beispiel ein Clip(Kinder) hat und der nächste Clip(Kinder, Freizeit) hat, darf dieser dann abgespielt werden oder müssen die tags 100% passen.Wenn sie 100% passen sollen wird es nicht viel Auswahl an passenden Clips geben.Wenn der Clip trotzdem abgespielt werden soll, wäre die Regel, nehme einen Clip bei welchem mindestens 1 Tag mit dem vorhergehenden übereinstimmt. Das kann allerdings ziemliche Sprünge ergeben z.b. AktionClip(Kinder Freizeit) -> ReaktionErzwingen(Freizeit, Monogamie, Zusammenziehen) -> Reaktion(Zusammenziehen).Innerhalb eines Argumetationsstranges hat das Thema komplett gewechselt.Eine Lösung wäre es Primär- und Sekundärtags zu verwenden, allerdings müsste dann die komplette Datenbank sowie eure Metadaten geändert werden.Oder man könnte eine Hierarchie der Tags festlegen z.b. Kinder ist immer stärker als Freizeit usw. , dann könnte ich das recht einfach einbauen ohne viel zu ändern. Allerdings ist es bestimmt schwer eine allgemeingültige Hierarchie festzulegen.Oder man streicht die Mehrfachvertaggung und ein Clip besitzt nur 1 Tag. Oder wir belassen es erstmal so und ihr schaut euch dann die erste Debugversion an und entscheidet dann was man ändern könnte oder ob es vielleicht doch funktioniert.- LISTE MIT GEÄNDERTEN CLIPNAMEN FEHLT NOCH!!!*////////////////package  {		import flash.events.*;	import flash.display.*;	import flash.utils.Dictionary;	import Player;	import Wedding2Object;	import Utils;	import flash.accessibility.Accessibility;		public class CalcWedding2 {		public function CalcWedding2() {			// constructor code		}				/////////////		//VARIABLES//		/////////////		//most important		private var randNum:int;				//Intro		private var intro:Array;		//Outro		private var outro:Array;				//ARRAYS		private var manAction:Array;		private var manReaction:Array;		private var manForceReaction:Array;		private var manBridge:Array;				private var womanAction:Array;		private var womanReaction:Array;		private var womanForceReaction:Array;		private var womanBridge:Array;				private var uniEvent:Array;		private var listOfFilteredObjects:Array;				//BOOLEANS		private var isMan:Boolean;		private var isBridge:Boolean;		private var bBridgePossible:Boolean;				//NUMBERS		private var argumentCounter:int;				//STRINGS		//private var strategyReaction:String;		private var intensityReaction:int;		private var intensityAction:int;		private var intensityForceReaction:int;		private var clipNameOfObjectToRemove:String;				//OBJECTS		private var tagsReaction:Object;		private var tagsAction:Object;		private var tagsForceReaction:Object;		private var tagsBlackList:Object;				private var playList: Array;		private var videoObjects: Array;		public var metaList:Array;				public function calculateClips(xml:XMLList): Array 		{			playList = new Array ();			videoObjects = new Array ();			Utils.allFilesNames = new Array();			metaList = new Array();			intro = new Array();			outro = new Array();						manAction = new Array();			manReaction = new Array();			manForceReaction = new Array();			manBridge = new Array();						womanAction = new Array();			womanReaction = new Array();			womanForceReaction = new Array();			womanBridge = new Array();							uniEvent = new Array();			listOfFilteredObjects = new Array();						metaList = new Array();						for (var i:int = 0; i<xml.length(); i++)			{								videoObjects[i] = new Wedding2Object (i,													  xml[i].clipname.text(),													  xml[i].dramaturgy.text(),													  xml[i].role.text(),													  xml[i].strategy.text(),													  xml[i].intensity.text(),													  xml[i].kids.text(),													  xml[i].wedding.text(),													  xml[i].leisure.text(),													  xml[i].monogamy.text(),													  xml[i].living_together.text()													  												 		);								Utils.allFilesNames.push(videoObjects[i].getClipName);								if(videoObjects[i].getDramaturgy == "intro") intro.push(videoObjects[i]);				if(videoObjects[i].getDramaturgy == "outro") outro.push(videoObjects[i]);								if(videoObjects[i].getRole == "woman" && videoObjects[i].getDramaturgy != "intro" && videoObjects[i].getDramaturgy != "outro")				{					//trace();					switch(videoObjects[i].getDramaturgy)					{						case "action":							womanAction.push(videoObjects[i]);						break;						case "reaction":							womanReaction.push(videoObjects[i]);						break;						case "forced_reaction":							womanForceReaction.push(videoObjects[i]);						break;						case "bridge":							womanBridge.push(videoObjects[i]);						break;					}				}								else if(videoObjects[i].getRole == "man" && videoObjects[i].getDramaturgy != "intro" && videoObjects[i].getDramaturgy != "outro")				{					switch(videoObjects[i].getDramaturgy)					{						case "action":							manAction.push(videoObjects[i]);						break;						case "reaction":							manReaction.push(videoObjects[i]);						break;						case "forced_reaction":							manForceReaction.push(videoObjects[i]);						break;						break;						case "bridge":							manBridge.push(videoObjects[i]);						break;					}				}				else if(videoObjects[i].getDramaturgy == "event") uniEvent.push(videoObjects[i]);							}						//ASSEMBLING PLAYLIST////////////////////////////////////////////////////////////////////////////////									//trace("Man Action:"  + manAction.length) ;			trace("Man Reaction:"  + manReaction.length) ;			//trace("Man Forced Reaction:"  + manForceReaction.length) ;			//trace("Man Bridge:"  + manBridge.length) ;						//trace("Woman Action:"  + womanAction.length) ;			//trace("Woman Reaction:"  + womanReaction.length) ;			//trace("Woman Forced Reaction:"  + womanForceReaction.length) ;			//trace("Woman Bridge:"  + womanBridge.length) ;						//set argumentCounter 0 for RULE 9			argumentCounter = 0;						//determine first parameters			isMan = Utils.randRound(2); // 0 = woman starts / 1 = man starts									///___________TEST			/*			for(var i:int = 0; i < manReaction.length; i++)			{				if(1 == manReaction[i].getIntensity)				{					var loopHash:Object = contentTagsHash(manReaction[i]); 					var counter:int = 0;					//check for same tags					for(var key in loopHash)					{						if(loopHash[key] == "true")						{							counter++;							trace(key + " : " + counter);						}					}										if(counter > 0)					{						trace("matching object found : counter = " + counter);					}				}			}			*/			///___________									//intro			if(intro.length != 0) playList.push(intro[0].getClipName);						playList.push(firstArgument().getClipName);			trace("First Argument: " + playList[playList.length - 1]);			Utils.removeWithClipName(listOfFilteredObjects, clipNameOfObjectToRemove);									for(var i:int = 0; i < 10; i++)			{				if(isBridge && argumentCounter > 1)				{					trace("------------------------------------");					playList.push(bridgeOrEvent().getClipName);					trace("Clip Bridge or Event: " + playList[playList.length - 1]);					//removal (both event and bridge: one of 2 functions is useless but less code)					Utils.removeWithClipName(uniEvent, playList[playList.length - 1]);					Utils.removeWithClipName(listOfFilteredObjects, playList[playList.length - 1]);				}				else				{					trace("------------------------------------");					playList.push(forceReaction().getClipName);					trace("Clip Force Reaction: " + playList[playList.length - 1]);					Utils.removeWithClipName(listOfFilteredObjects, playList[playList.length - 1]);				}								trace("------------------------------------");				playList.push(reaction().getClipName);				trace("Clip Reaction: " + playList[playList.length - 1]);				Utils.removeWithClipName(listOfFilteredObjects, playList[playList.length - 1]);				trace("------------------------------------");				playList.push(argument().getClipName);				trace("Clip Argument: " + playList[playList.length - 1]);				Utils.removeWithClipName(listOfFilteredObjects, playList[playList.length - 1]);							}													//end event			if(uniEvent.length != 0) playList.push(uniEvent[Utils.randRound(uniEvent.length)].getClipName);			//outro			if(outro.length != 0) playList.push(outro[0].getClipName);						//////////////////////////////////////////////////////////////////////////////////////////////////////			Utils.checkForDuplicates(playList);			trace(playList);			return playList;		}												//////////////////		//MAIN FUNCTIONS//		//////////////////			// FIRST ARGUMENT		private function firstArgument():Wedding2Object		{			if(isMan)			{				return firstArgumentFunction(manAction);			}			else			{				return firstArgumentFunction(womanAction);			}			trace("ERROR IN FIRST ARGUMENT");		}						//FORCE REACTION		private function forceReaction():Wedding2Object		{			if(isMan)			{				isMan = false;				return forceReactionFunction(manForceReaction);			}			else			{				isMan = true;				return forceReactionFunction(womanForceReaction);							}			trace("ERROR IN FORCE REACTION");		}						//REACTION		private function reaction():Wedding2Object		{			if(isMan)			{				return reactionFunction(manReaction);			}			else			{				return reactionFunction(womanReaction);			}			trace("ERROR IN REACTION");		}						//ARGUMENT		private function argument():Wedding2Object		{			if(isMan)			{				isMan = false;				return argumentFunction(manAction);			}			else			{				isMan = true;				return argumentFunction(womanAction);			}			trace("ERROR IN ARGUMENT");		}								//BRIDGE OR EVENT (RULE:9)		private function bridgeOrEvent():Wedding2Object		{			isBridge = Utils.randRound(2); // Decide if Bridge or Event clip						if(isBridge)			{				trace("- BRIDGE");				isBridge == false;				if(isMan)				{					return bridgeFunction(manBridge, tagsForceReaction);				}				else				{					return bridgeFunction(womanBridge, tagsForceReaction);				}			}			else			{				trace("- EVENT");				randNum = Utils.randRound(uniEvent.length);				return uniEvent[randNum];			}		}					/////////////		//THE HEART//		/////////////						//FIRST ARGUMENT		private function firstArgumentFunction(objectArray:Array):Wedding2Object		{			//choose Argument with intensinty "weak"			var matchingObjects:Array = new Array();					for(var i:int = 0; i < objectArray.length; i++)			{				if(1 == objectArray[i].getIntensity)				{					matchingObjects.push(objectArray[i]);				}			}			//if pool of possibilities is empty			if(matchingObjects.length == 0) 			{				//trace("ERROR: no FirstArgument could be found");			}						randNum = Utils.randRound(matchingObjects.length);						//for removal			listOfFilteredObjects = objectArray;			clipNameOfObjectToRemove = matchingObjects[randNum].getClipName;						intensityForceReaction = matchingObjects[randNum].getIntensity; // should always be 1			metaList.push(matchingObjects[randNum]);			tagsForceReaction = contentTagsHash(matchingObjects[randNum]);			//put tag in blackList so Rule 9 doesnt choose			return matchingObjects[randNum];		}						//FORCE REACTION		private function forceReactionFunction(objectArray:Array):Wedding2Object		{						var matchingObjects:Array = new Array();			if(!bIntensityAndContent(objectArray, intensityForceReaction, tagsForceReaction, matchingObjects) && intensityForceReaction <= 3 ) // check Intensity 1			{				intensityForceReaction ++;			   	if(!bIntensityAndContent(objectArray, intensityForceReaction, tagsForceReaction, matchingObjects) && intensityForceReaction <= 3 ) // check intensity 2				{					intensityForceReaction ++;  					if(!bIntensityAndContent(objectArray, intensityForceReaction, tagsForceReaction, matchingObjects)) // check intensity 3 (if false no clips with specifications available)					{ 						trace("ERROR: STRONGEST INTENSITY FOR FORCE REACTION BUT NO MORE MATCHING TAGS WITH OBJECTS");					}			  	}		   	}								//for removal			listOfFilteredObjects = objectArray;			//clipNameOfObjectToRemove = matchingObjects[randNum].getClipName;			randNum = Utils.randRound(matchingObjects.length);						intensityReaction = matchingObjects[randNum].getIntensity;			metaList.push(matchingObjects[randNum]);			tagsReaction = contentTagsHash(matchingObjects[randNum]);			return matchingObjects[randNum];		}						//REACTION		private function reactionFunction(objectArray:Array):Wedding2Object		{			var matchingObjects:Array = new Array();			if(!bIntensityAndContent(objectArray, intensityReaction, tagsReaction, matchingObjects) && intensityReaction <= 3 )			{				intensityReaction ++;			   	if(!bIntensityAndContent(objectArray, intensityReaction, tagsReaction, matchingObjects) && intensityReaction <= 3 )				{					intensityReaction ++;  					if(!bIntensityAndContent(objectArray, intensityReaction, tagsReaction, matchingObjects))					{						trace("ERROR: STRONGEST INTENSITY FOR REACTION BUT NO MORE MATCHING TAGS WITH OBJECTS");					}			  	}		   	}						//for removal			listOfFilteredObjects = objectArray;						randNum = Utils.randRound(matchingObjects.length);						intensityAction = matchingObjects[randNum].getIntensity;			metaList.push(matchingObjects[randNum]);			tagsAction = contentTagsHash(matchingObjects[randNum]);			return matchingObjects[randNum];		}						//ARGUMENT		private function argumentFunction(objectArray:Array):Wedding2Object		{			var matchingObjects:Array = new Array();			if(!bIntensityAndContent(objectArray, intensityAction, tagsAction, matchingObjects) && intensityAction <= 3 )			{				intensityAction++;			   	if(!bIntensityAndContent(objectArray, intensityAction, tagsAction, matchingObjects) && intensityAction <= 3 )				{					intensityAction++;  					if(!bIntensityAndContent(objectArray, intensityAction, tagsAction, matchingObjects))					{						trace("ERROR: STRONGEST INTENSITY FOR ACTION BUT NO MORE MATCHING TAGS WITH OBJECTS");											}			  	}		   	}								randNum = Utils.randRound(matchingObjects.length);						//for removal			listOfFilteredObjects = objectArray;			//for debug			metaList.push(matchingObjects[randNum]);						intensityForceReaction = matchingObjects[randNum].getIntensity;			tagsForceReaction = contentTagsHash(matchingObjects[randNum]);						//RULE:9			if(isBridge)			{				argumentCounter++;				if(argumentCounter == 2) blackListTags(tagsBlackList, tagsForceReaction);			}			else argumentCounter = 0;						return matchingObjects[randNum];		}						// BRIDGE FUNCTION		private function bridgeFunction(objectArray:Array, tags:Object):Wedding2Object		{			var matchingObjects:Array = new Array();			// check if tags are on blackList			for(var i:int = 0; i < objectArray.length; i++)			{				if(!bIsBlackListed(tagsBlackList, tags))				{					matchingObjects.push(objectArray[i]);				}			}						randNum = Utils.randRound(matchingObjects.length);			metaList.push(matchingObjects[randNum]);			return matchingObjects[randNum];		}				/////////////////////		//HELPING FUNCTIONS//		/////////////////////						private function contentTagsHash(thisObject:Wedding2Object):Object		{			var hashMap:Object = {				kids:thisObject.getKids,				wedding:thisObject.getWedding,				leisure:thisObject.getLeisure,				monogamy:thisObject.getMonogamy,				livingTogether:thisObject.getLivingTogether			}			return hashMap;		}				//Black list  certain Tags so they won't be repeated		private function blackListTags(blackList:Object, tagObjectToBlackList:Object):void		{			for(var key in tagObjectToBlackList)			{				if(tagObjectToBlackList[key] == "true")				{					blackList[key] == true;					trace(blackList[key] + " is now on blackList");				}			}		}						// ceck Object for BlackListed Tags		private function bIsBlackListed(blackList:Object, tagObjectToCheck:Object):Boolean		{			if(blackList != null)			{				for(var key in tagObjectToCheck)				{					if(tagObjectToCheck[key] == blackList[key] && blackList[key] == true) // if tag is same as in blackList					{						trace("black listed Object " + blackList[key] + " found.");						return true;					}					else return false;				}			}			else			{				//trace("BlackList is still empty");				return false;			}			trace("ERROR IN bIsBlackListed FUNCTION");			return true;		}						private function bIntensityAndContent(objectArray:Array, intensity:int, tags:Object, _matchingObjects:Array):Boolean		{			//var matchingObjects:Array = new Array();			// RULE: If strongest Intesnsity (3) reached Bridge and EventClips are allowed			if(intensity == 3) 			{				bBridgePossible = true;			}			else bBridgePossible = false;						for(var i:int = 0; i < objectArray.length; i++)			{				if(intensity == objectArray[i].getIntensity && !bIsBlackListed(tagsBlackList, tags))				{					var loopHash:Object = contentTagsHash(objectArray[i]); 					var counter:int = 0;					//check for same tags					for(var key in loopHash)					{						if(tags[key] == loopHash[key] && tags[key] == "true")						{							counter++;							//trace(key + " : " + counter);						}					}										if(counter > 0)					{						//trace("matching object found : counter = " + counter);						_matchingObjects.push(objectArray[i]);					}				}			}			if(_matchingObjects.length == 0) 			{				trace("_matchingObjects == 0");				return false;			}			else return true;		}			//-----------------------------END--------------------------------------------	}	}