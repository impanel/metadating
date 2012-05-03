﻿package  {		import flash.events.*;	import flash.display.*;	import flash.utils.Dictionary;	import Player;	import MeatObject;	import Utils;			public class CalcMeat {				public function CalcMeat() {			// constructor code		}				/////////////		//VARIABLES//		/////////////				//Intro		private var intro:Array;		//Outro		private var outro:Array;				private var nicoPro:Array;		private var nicoContra:Array;		private var nicoReaction:Array;		private var caroPro:Array;		private var caroContra:Array;		private var caroReaction:Array;		private var usedVideosNico:Array;		private var usedVideosCaro:Array;		private var usedVideos:Array;				private var objectToRemove:Array;		private var oldSubject:Array;		private var newSubject:Array;		private var reactFrequency:int;		private var introName:String;						//Funktionsvariablen		private var introArray:Array = new Array();		//private var argument:Array = [nicoPro, nicoContra, caroPro, caroContra];		private var argumentArray:Array = new Array();		private var reactionArray:Array = new Array();		private var reaction:Array = [nicoReaction, caroReaction];				private var introClip:String;		private var randNum:int;		private var group1Contra:Boolean;		private var group1Begin:Boolean;		private var strategyReaction:String;		private var strategyAction:String;		private var strategyCurrent:String;		private var subjectCurrent:Array = new Array();		private var subjectsAvailable:Array = ["animal_rights", "healthy", "environment", "lifestyle", "economy", "taste"];		private var checkedSubjectList:Array = new Array();		private var currentSubjectList:Array = new Array();		private var previousSubjectList:Array;		private var makeThisSubject:Array;		private var nextSubject:Array;		private var currentGroup:int;		private var indexNum:int;		//private var tags:Object;		private var nextTags:Object;		private var strength:int;		private var oldStrength:int;				//		private var playList: Array;		private var videoObjects: Array;				private var testArray:Array = new Array();				// Save calculated MeatObjects in this Array for use in Debug TextField		public var metaList: Array;						////////////////////////		//MAIN PUBLIC FUNCTION//		////////////////////////				public function calculateClips(xml:XMLList): Array {			playList = new Array ();			metaList = new Array();			videoObjects = new Array ();			intro = new Array();			outro = new Array();			nicoPro = new Array();			nicoContra = new Array();			nicoReaction = new Array();			caroPro = new Array();			caroContra = new Array();			caroReaction = new Array();			usedVideosNico = new Array();			usedVideosCaro = new Array();			usedVideos = new Array();			newSubject = new Array();			oldSubject = new Array();			Utils.allFilesNames = new Array();						//Videobjecte parsen und in Array legen			for (var i:int = 0; i<xml.length(); i++)			{				videoObjects[i] = new MeatObject (													i, 																		//xml[i].file.text(),															xml[i].user_id.text(),														xml[i].frequency.text(),													xml[i].clipname.text(),													xml[i].strategy.text(),													xml[i].dramaturgy.text(),													xml[i].pro_contra_reaction.text(),													xml[i].animal_rights.text(),													xml[i].environment.text(),													xml[i].healthy.text(),													xml[i].lifestyle.text(),													xml[i].economy.text(),													xml[i].taste.text()																);								Utils.allFilesNames.push(videoObjects[i].getClipName);								//Intro				if(videoObjects[i].dramaturgy == "intro"){					intro.push(videoObjects[i]);				}								// Sortiere Gruppe 1 (Nico)				if(videoObjects[i].user_id == 1 && videoObjects[i].dramaturgy != "intro" && videoObjects[i].dramaturgy != "outro"){					if(videoObjects[i].pro_contra_reaction == "pro"){						nicoPro.push(videoObjects[i]);					}					else if(videoObjects[i].pro_contra_reaction == "contra"){						nicoContra.push(videoObjects[i]);					}else{						nicoReaction.push(videoObjects[i]);					}				}												// Sortiere Gruppe 2 (Caro)				if(videoObjects[i].user_id == 2 && videoObjects[i].dramaturgy != "intro" && videoObjects[i].dramaturgy != "outro"){					if(videoObjects[i].pro_contra_reaction == "pro"){						caroPro.push(videoObjects[i]);					}					else if(videoObjects[i].pro_contra_reaction == "contra"){						caroContra.push(videoObjects[i]);					}else{						caroReaction.push(videoObjects[i]);					}				}												//Outro				if(videoObjects[i].dramaturgy == "outro"){					outro.push(videoObjects[i]);				}											}									//-----ASSEMBLE PLAYLIST-----------------------------			//---------------------------------------------------							//whileLoopTest();			playList.push(introFunc(intro).getClipName);			playList.push(firstArgumentFunc().getClipName);			Utils.remove(objectToRemove, randNum);			reactFrequency = determineFrequency();			trace("Frequenz: " + reactFrequency);			playList.push(reactFunc().getClipName);			Utils.remove(objectToRemove, randNum);						for(var i:int = 0; i < 10; i++)			{				trace("-----------------------------");				//trace(checkedSubjectList);				trace("-----------------------------");				playList.push(argumentFunc().getClipName);				Utils.remove(objectToRemove, randNum);				reactFrequency = determineFrequency();				trace("Frequenz: " + reactFrequency);				playList.push(reactFunc().getClipName);				Utils.remove(objectToRemove, randNum);			}						playList.push(outro[0].getClipName);						//---------------------------------------------------						// print Array checkedSubjectList			/*for(var j:uint = 0; j< checkedSubjectList.length; j++){				trace(checkedSubjectList[j]);			}*/			/*var a:Array = ["carrot"];			var b:Array = ["milk", "tomato", "carrot"];			trace(compareSubjects(a, b));			trace(makeThisSubject);			trace(nextSubject);*/						trace(usedVideos);			//introName = playList[0].getClipName;			introName = "Intro_Blindate_Nico_Veg.mov";			switch(playList[0])			{				case "Intro_Blinddate_Nico_Veg.mov":				Utils._time = 40000;				//trace(Utils._time);				break;				case "Intro_Blinddate_Nico_Fleisch.mov":				Utils._time = 40000;				break;				case "Intro_Nachbar_Nico_Fleisch.mov":				Utils._time = 30900;				break;				case "Intro_Nachbar_Nico_Veg.mov":				Utils._time = 30900;				break;				case "Intro_Romeo_Nico_Fleisch.mov":				Utils._time = 39300;				break;				case "Intro_Romeo_Nico_Veg.mov":				Utils._time = 39300;				break;			}			trace("-----PLAYLIST-----");			trace(playList);			return playList;		}						//////////////////		//MAIN FUNCTIONS//		//////////////////								/////////		//INTRO//		/////////		private function introFunc(introArray) :MeatObject{						//introClip = introArray[Utils.randRound(intro.length)].getClipName;			randNum = Utils.randRound(introArray.length)			trace("RANDNUM = "+ randNum);			trace(introArray[randNum].getClipName);						//check which Group is Contra meat			if(introArray[randNum].getUserID == 1 && introArray[randNum].getProContraReaction == "pro"){				group1Contra = false;				group1Begin = false;			}else if(introArray[randNum].getUserID == 2 && introArray[randNum].getProContraReaction == "pro"){				group1Contra = true;				group1Begin = true;			}else if(introArray[randNum].getUserID == 1 && introArray[randNum].getProContraReaction == "contra"){				group1Contra = true;				group1Begin = false;			}else if(introArray[randNum].getUserID == 2 && introArray[randNum].getProContraReaction == "contra"){				group1Contra = false;				group1Begin = true;			}else trace("ERROR IN INTRO FUNCTION");						trace("Group1Contra = "+ group1Contra);			trace("Group1Begin = "+ group1Begin);			metaList.push(introArray[randNum]);			return introArray[randNum];		}										//////////////////		//FIRST ARGUMENT//		//////////////////						private function firstArgumentFunc() :MeatObject{			//argument:Array = [nicoPro, nicoContra, caroPro, caroContra];			if(group1Contra == true && group1Begin == true)			{				return firstArgument(nicoContra);							}						else if(group1Contra == false && group1Begin == true)			{				return firstArgument(nicoPro);			}						else if(group1Contra == false && group1Begin == false)			{				return firstArgument(caroContra);			}						else if(group1Contra == true && group1Begin == false)			{				return firstArgument(caroPro);			}			else return outro[0]; 		}										////////////		//REACTION//		////////////						private function reactFunc() :MeatObject{			if(currentGroup == 1){				return react(caroReaction);			}else{				return react(nicoReaction);			}			return outro[0];		}										////////////		//ARGUMENT//		////////////						private function argumentFunc():MeatObject{			currentSubjectList = checkedSubjectList;			if(currentGroup == 1){				if(group1Contra == true){ 					return argument(caroPro);				}else{					return argument(caroContra);				}			}else{				if(group1Contra == true){					return argument(nicoContra);				}else{					return argument(nicoPro);				}			}			return outro[0];		}										//////////////////////////		//MAIN SUPPORT FUNCTIONS//		//////////////////////////						private function firstArgument(objectArray:Array):MeatObject		{			randNum = Utils.randRound(objectArray.length);			strategyReaction = objectArray[randNum].getStrategy;			currentGroup = objectArray[randNum].getUserID;			oldSubject = getSubjects(objectArray[randNum]);			strength = objectArray[randNum].getFrequency;			trace(randNum);			metaList.push(objectArray[randNum]);			objectToRemove = objectArray;			return objectArray[randNum];		}				private function react(objectArray:Array):MeatObject		{			do			{				randNum = Utils.randRound(objectArray.length);				strategyCurrent = objectArray[randNum].getStrategy;			}			while(strategyReaction != strategyCurrent) 			trace("this Frequenz: " + objectArray[randNum].getFrequency + "  reactFrequency: " + reactFrequency);			metaList.push(objectArray[randNum]);			objectToRemove = objectArray;			return objectArray[randNum];		}				private function argument(objectArray:Array):MeatObject		{			oldStrength = strength;			do			{				randNum = Utils.randRound(objectArray.length);				newSubject = getSubjects(objectArray[randNum]);				strength = objectArray[randNum].getFrequency;			}			while(!checkNextSubjects(newSubject, oldSubject) || !checkStrength(oldStrength, strength));			oldSubject = newSubject;						strategyReaction = objectArray[randNum].getStrategy;			currentGroup = objectArray[randNum].getUserID;			usedVideos.push(objectArray[randNum].getClipName);			metaList.push(objectArray[randNum]);			getSubjects(objectArray[randNum]);			objectToRemove = objectArray;			return objectArray[randNum];		}								/////////////////////		//SUPPORT FUNCTIONS//		/////////////////////						private function getSubjects(object:MeatObject):Array		{			//var tags:Dictionary;			var numSubjects:int;			var thisSubjects:Array = new Array();			var thisTags:Object = {								animalRights:object.getAnimalRights,								environment:object.getEnvironment,								healthy:object.getHealthy,								lifestyle:object.getLifestyle,								economy:object.getEconomy,								taste:object.getTaste,								frequency:object.getFrequency							};										nextTags = thisTags;						//check wich tags are true and put the subject in array			for (var key:Object in thisTags)			{				//trace(key);				if(thisTags[key] == "true")				{					//trace(key + ": " + thisTags[key]);					thisSubjects.push(key);				}				//delete currentSubject[key];			}			// get number of subjects for this video			numSubjects = thisSubjects.length;			///trace("numSubjects: " + numSubjects + ": " + thisSubjects);			return thisSubjects;					}						private function checkNextSubjects(newSub:Array, oldSub:Array):Boolean		{			var makeThisNewSubject:Array = new Array();			var same:Array = new Array();			var different:Array = new Array();						for(var i:int = 0; i< newSub.length; i++){				for(var j:int = 0; j< oldSub.length; j++){					if(newSub[i] == oldSub[j]){						//trace(array1[i] + " and " + array2[j]);						same.push(oldSub[j]);					}else different.push(oldSub[j]);// this will be the new subject				}			}						if(same.length == 0)return false;			else return true;		}						private function checkSubjectList(objectToCheck:MeatObject): void {			var subjectList:Array = new Array ();			subjectList.push(objectToCheck.getAnimalRights);			subjectList.push(objectToCheck.getEnvironment);			subjectList.push(objectToCheck.getHealthy);			subjectList.push(objectToCheck.getLifestyle);			subjectList.push(objectToCheck.getEconomy);					subjectList.push(objectToCheck.getTaste);									/*for(var i:uint = 0; i< subjectList.length; i++){				trace(subjectList[i]);			}*/						for(var i:uint = 0; i< subjectsAvailable.length; i++){				if(subjectList[i] == "true"){					checkedSubjectList.push(subjectsAvailable[i]);				}			}		}						private function determineFrequency():int		{			var frequency:int = Utils.randRound(6);			trace("Frequenz RandNum: " + frequency);			if(frequency < 5)			{				if(frequency < 3) return 3;				else return 2;			}else return 1;		}				// if current Argument has a Frequency(Strength) of ....		private function checkStrength(oldStrength:int, newStrength):Boolean		{			if(oldStrength == 3)			{				if(newStrength == 2) return true;				else if(newStrength == 3) return true;				else return false;			}			else if(oldStrength == 2) return true;			else if(oldStrength == 1)			{				if(newStrength == 2) return true;				else if(newStrength == 1) return true;				else return false;			}			else return false		}						/* //OLD FUNCTIONS				private function compareSubjects(array1:Array, array2:Array): Boolean{			makeThisSubject = new Array();			nextSubject = new Array();			//check for similar items in both arrays and create an array that will determine the Subject to be played and the next subject			for(var i:int = 0; i< array1.length; i++){				for(var j:int = 0; j< array2.length; j++){					if(array1[i] == array2[j]){						//trace(array1[i] + " and " + array2[j]);						makeThisSubject.push(array2[j]);					}else nextSubject.push(array2[j]);				}											}			// remove similar items from array so the next subject won't be the same as it already is			for(var i:int = 0; i< nextSubject.length; i++){				if(nextSubject[i] == makeThisSubject[0]){					nextSubject.splice(i,1);				}			}			//check if similar objects were found and return true otherwise return false			if(makeThisSubject.length == 0){				return false;			}else{				return true;			}		}				private function checkIfUsed(thisClipName:String):Boolean{			trace(usedVideos + " : " + thisClipName);			for(var i:int = 0; i < usedVideos.length; i++){				if(thisClipName == usedVideos[i]){					trace("used" + thisClipName);					return true;				}			}			trace("unused");			return false;		}			*/	}}