-- MySQL dump 10.13  Distrib 5.1.40, for none-linux-gnueabi (arm)
--
-- Host: localhost    Database: ares
-- ------------------------------------------------------
-- Server version	5.1.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `3MDemo`
--

DROP TABLE IF EXISTS `3MDemo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `3MDemo` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(80) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `3MDemo`
--

LOCK TABLES `3MDemo` WRITE;
/*!40000 ALTER TABLE `3MDemo` DISABLE KEYS */;
INSERT INTO `3MDemo` VALUES ('Car detector count','<?=$9950_DETECTOR_COUNT?>','9950','10');
/*!40000 ALTER TABLE `3MDemo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `About`
--

DROP TABLE IF EXISTS `About`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `About` (
  `Name` varchar(45) NOT NULL,
  `Value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `About`
--

LOCK TABLES `About` WRITE;
/*!40000 ALTER TABLE `About` DISABLE KEYS */;
INSERT INTO `About` VALUES ('HW_SERIAL_C','1234564321'),('HW_SERIAL_P','9999888822'),('TIMER_HW_REVISION','THR_0.1'),('TIMER_HW_VERSION','THV_0.3'),('BBC_SW_REVISION','BBC_S_0.1'),('BBC_BUILD_DATE_TIME','15/04/2013 13:04'),('DSP_VERSION','DSP_V99'),('DSP_BOOTSTRAP_REVISION','DSP_BS_1'),('NR_VERSION','MDX_01'),('TIMER_SW_VERSION','TSV_0.7');
/*!40000 ALTER TABLE `About` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdvIO`
--

DROP TABLE IF EXISTS `AdvIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdvIO` (
  `PinID` int(11) NOT NULL,
  `PinMode` int(11) NOT NULL,
  `PinSourceID` varchar(45) NOT NULL,
  PRIMARY KEY (`PinID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdvIO`
--

LOCK TABLES `AdvIO` WRITE;
/*!40000 ALTER TABLE `AdvIO` DISABLE KEYS */;
INSERT INTO `AdvIO` VALUES (1,0,'SPLIT_CROSS'),(2,0,'OT_MODE'),(3,0,'DAY_NIGHT'),(4,0,'EXT_MSG'),(5,0,'GREET15'),(6,0,'GREET16'),(7,0,'UNUSED'),(8,0,'VEHAPP1'),(9,0,'VEHAPP2'),(10,1,'UNUSED'),(11,1,'TALK1'),(12,1,'PAGE1'),(13,1,'TALK2'),(14,1,'PAGE2'),(15,1,'GRTCNCL1'),(16,1,'GRTCNCL2'),(17,1,'VEHDET1'),(18,1,'VEHDET2');
/*!40000 ALTER TABLE `AdvIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdvIOPinSources`
--

DROP TABLE IF EXISTS `AdvIOPinSources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdvIOPinSources` (
  `SourceID` varchar(45) NOT NULL,
  `MsgID` int(11) NOT NULL DEFAULT '255',
  `AllowedInPinMode` int(11) NOT NULL,
  `PinID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`SourceID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdvIOPinSources`
--

LOCK TABLES `AdvIOPinSources` WRITE;
/*!40000 ALTER TABLE `AdvIOPinSources` DISABLE KEYS */;
INSERT INTO `AdvIOPinSources` VALUES ('UNUSED',255,2,0),('SPLIT_CROSS',255,0,0),('OT_MODE',255,0,0),('DAY_NIGHT',255,0,0),('EXT_MSG',255,0,0),('VEHAPP1',255,0,0),('VEHAPP2',255,0,0),('VEHDET1',255,1,0),('GREET01',1,0,0),('GREET02',2,0,0),('GREET03',3,0,0),('GREET04',4,0,0),('GREET05',5,0,0),('GREET06',6,0,0),('GREET07',7,0,0),('GREET08',8,0,0),('GREET09',9,0,0),('GREET10',10,0,0),('GREET11',11,0,0),('GREET12',12,0,0),('GREET13',13,0,0),('GREET14',14,0,0),('GREET15',15,0,0),('GREET16',16,0,0),('VEHDET2',255,1,0),('TALK1',255,1,0),('TALK2',255,1,0),('PAGE1',255,1,0),('PAGE2',255,1,0),('GRTCNCL1',255,1,0),('GRTCNCL2',255,1,0),('IO1',255,1,1),('IO2',255,1,2),('IO3',255,1,3),('IO4',255,1,4),('IO5',255,1,5),('IO6',255,1,6),('IO7',255,1,7),('IO8',255,1,8),('IO9',255,1,9),('IO10',255,1,10),('IO11',255,1,11),('IO12',255,1,12),('IO13',255,1,13),('IO14',255,1,14),('IO15',255,1,15),('IO16',255,1,16);
/*!40000 ALTER TABLE `AdvIOPinSources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CloudSettings`
--

DROP TABLE IF EXISTS `CloudSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CloudSettings` (
  `textID` varchar(40) NOT NULL,
  `dataValue` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CloudSettings`
--

LOCK TABLES `CloudSettings` WRITE;
/*!40000 ALTER TABLE `CloudSettings` DISABLE KEYS */;
INSERT INTO `CloudSettings` VALUES ('CloudEnabled','RADIO_YES'),('CloudAddress','10.8.8.12'),('CloudPort','1883'),('CloudUsername','jon'),('CloudPassword','jon'),('CloudConnectionStatus','Running'),('CloudStatusExpiration','1664181495'),('AsrCloudPort','1883'),('AsrCloudAddress','staging.mqtt.conversenow.ai'),('AsrCloudUsername',''),('AsrCloudPassword','');
/*!40000 ALTER TABLE `CloudSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DL2MonitorVolume`
--

DROP TABLE IF EXISTS `DL2MonitorVolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DL2MonitorVolume` (
  `ID` int(11) NOT NULL,
  `Type` varchar(45) NOT NULL,
  `Volume` varchar(45) NOT NULL,
  `State` int(1) NOT NULL,
  `MinValue` int(3) NOT NULL,
  `MaxValue` int(3) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Type_UNIQUE` (`Type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DL2MonitorVolume`
--

LOCK TABLES `DL2MonitorVolume` WRITE;
/*!40000 ALTER TABLE `DL2MonitorVolume` DISABLE KEYS */;
INSERT INTO `DL2MonitorVolume` VALUES (1,'InboundListen','10',1,0,20),(2,'OutboundTalk','2',1,0,20),(3,'VehiclePresent','2',1,0,20),(4,'VehicleApproach','10',1,0,20),(5,'PageMessages','2',1,0,20),(6,'ExternalAudioIn','10',1,0,20),(7,'GreeterMessages','10',1,0,20),(8,'DL2Mix','0',0,0,20);
/*!40000 ALTER TABLE `DL2MonitorVolume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DL2NightVolume`
--

DROP TABLE IF EXISTS `DL2NightVolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DL2NightVolume` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DL2NightVolume`
--

LOCK TABLES `DL2NightVolume` WRITE;
/*!40000 ALTER TABLE `DL2NightVolume` DISABLE KEYS */;
INSERT INTO `DL2NightVolume` VALUES (2,'ReduceDriveThruVolBy','0','text',1);
/*!40000 ALTER TABLE `DL2NightVolume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DL2NightVolumeParams`
--

DROP TABLE IF EXISTS `DL2NightVolumeParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DL2NightVolumeParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DL2NightVolumeParams`
--

LOCK TABLES `DL2NightVolumeParams` WRITE;
/*!40000 ALTER TABLE `DL2NightVolumeParams` DISABLE KEYS */;
INSERT INTO `DL2NightVolumeParams` VALUES ('ReduceDriveThruVolBy','MIN_INT_VALUE','0',''),('ReduceDriveThruVolBy','MAX_INT_VALUE','20',NULL);
/*!40000 ALTER TABLE `DL2NightVolumeParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DL2NoiseReduction`
--

DROP TABLE IF EXISTS `DL2NoiseReduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DL2NoiseReduction` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DL2NoiseReduction`
--

LOCK TABLES `DL2NoiseReduction` WRITE;
/*!40000 ALTER TABLE `DL2NoiseReduction` DISABLE KEYS */;
INSERT INTO `DL2NoiseReduction` VALUES (1,'IMNRL','IMNRL_Medium','select',NULL),(2,'AEC','AEC_Medium','select',NULL);
/*!40000 ALTER TABLE `DL2NoiseReduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DL2NoiseReductionParams`
--

DROP TABLE IF EXISTS `DL2NoiseReductionParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DL2NoiseReductionParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DL2NoiseReductionParams`
--

LOCK TABLES `DL2NoiseReductionParams` WRITE;
/*!40000 ALTER TABLE `DL2NoiseReductionParams` DISABLE KEYS */;
INSERT INTO `DL2NoiseReductionParams` VALUES ('AEC','AEC_Off','0','1'),('AEC','AEC_Minimum','1','2'),('AEC','AEC_Low','2','3'),('AEC','AEC_Medium','3','4'),('AEC','AEC_Maximum','4','5'),('IMNRL','IMNRL_Off','0','1'),('IMNRL','IMNRL_Minimum','1','2'),('IMNRL','IMNRL_Maximum','5','6'),('IMNRL','IMNRL_Low','2','3'),('IMNRL','IMNRL_Medium','3','4'),('IMNRL','IMNRL_High','4','5');
/*!40000 ALTER TABLE `DL2NoiseReductionParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DL2Volume`
--

DROP TABLE IF EXISTS `DL2Volume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DL2Volume` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DL2Volume`
--

LOCK TABLES `DL2Volume` WRITE;
/*!40000 ALTER TABLE `DL2Volume` DISABLE KEYS */;
INSERT INTO `DL2Volume` VALUES (1,'MicVol','17','text',1),(2,'TalkVol','15','text',1),(3,'VehicleAlertVol','10','text',1),(4,'GreeterVol','10','text',1),(5,'ExternalVol','10','text',1),(6,'LabelMicPreampGain','8','text',1);
/*!40000 ALTER TABLE `DL2Volume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DL2VolumeParams`
--

DROP TABLE IF EXISTS `DL2VolumeParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DL2VolumeParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DL2VolumeParams`
--

LOCK TABLES `DL2VolumeParams` WRITE;
/*!40000 ALTER TABLE `DL2VolumeParams` DISABLE KEYS */;
INSERT INTO `DL2VolumeParams` VALUES ('MicVol','MIN_INT_VALUE','0',NULL),('MicVol','MAX_INT_VALUE','20',NULL),('TalkVol','MIN_INT_VALUE','0',NULL),('TalkVol','MAX_INT_VALUE','20',NULL),('VehicleAlertVol','MIN_INT_VALUE','0',NULL),('VehicleAlertVol','MAX_INT_VALUE','20',NULL),('GreeterVol','MIN_INT_VALUE','0',NULL),('GreeterVol','MAX_INT_VALUE','20',NULL),('ExternalVol','MIN_INT_VALUE','0',NULL),('ExternalVol','MAX_INT_VALUE','20',NULL),('LabelMicPreampGain','MIN_INT_VALUE','0',NULL),('LabelMicPreampGain','MAX_INT_VALUE','20',NULL);
/*!40000 ALTER TABLE `DL2VolumeParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetectorConfig`
--

DROP TABLE IF EXISTS `DetectorConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DetectorConfig` (
  `ID` int(11) NOT NULL,
  `Name` varchar(30) NOT NULL COMMENT 'The name of the detector',
  `DetectorType` int(11) NOT NULL DEFAULT '1' COMMENT 'The type of detector: 1 = PRESENCE 0 = PULSE',
  `ThresholdMin` int(11) NOT NULL DEFAULT '0' COMMENT 'Minimum time in seconds vehicle is on detector before the system considers a vehicle has been detected',
  `ThresholdMax` int(11) NOT NULL DEFAULT '9' COMMENT 'Maximum time in minutes vehicle dwells on the vehicle detector',
  `InputSource` int(11) NOT NULL COMMENT 'Not used - was going to be used to allow the detectors to be ordered as per the user''s requirement rather than in index order.',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='The configuration of the various vehicle detectors.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetectorConfig`
--

LOCK TABLES `DetectorConfig` WRITE;
/*!40000 ALTER TABLE `DetectorConfig` DISABLE KEYS */;
INSERT INTO `DetectorConfig` VALUES (4,'Order Point2',1,0,9,3),(3,'Pick Up     ',1,0,9,2),(1,'Order point1',1,0,9,0),(2,'Pay Window  ',1,0,9,1),(5,'Spare 1     ',1,0,9,4),(6,'Spare 2     ',1,0,9,5),(7,'Greet Event ',1,0,9,6),(8,'Not Fitted  ',1,0,9,7);
/*!40000 ALTER TABLE `DetectorConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetectorDetails`
--

DROP TABLE IF EXISTS `DetectorDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DetectorDetails` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(40) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetectorDetails`
--

LOCK TABLES `DetectorDetails` WRITE;
/*!40000 ALTER TABLE `DetectorDetails` DISABLE KEYS */;
INSERT INTO `DetectorDetails` VALUES ('Name | Detector 1','<?=$262_detectorNameID1?>','262','Order Point1'),('Name | Detector 2','<?=$267_detectorNameID2?>','267','Pay Window'),('Name | Detector 3','<?=$272_detectorNameID3?>','272','Pick Up'),('Name | Detector 4','<?=$277_detectorNameID4?>','277','Order Point2'),('Name | Detector 5','<?=$282_detectorNameID5?>','282','Spare 1'),('Name | Detector 6','<?=$287_detectorNameID6?>','287','Spare 2'),('Type | Detector 1','<?=$263_detectorTypeID1?>','263','PRESENCE'),('Type | Detector 2','<?=$268_detectorTypeID2?>','268','PRESENCE'),('Type | Detector 3','<?=$273_detectorTypeID3?>','273','PRESENCE'),('Type | Detector 4','<?=$278_detectorTypeID4?>','278','PRESENCE'),('Type | Detector 5','<?=$283_detectorTypeID5?>','283','PRESENCE'),('Type | Detector 6','<?=$288_detectorTypeID6?>','288','PRESENCE'),('MIN | Detector 1','<?=$265_threMinID1?>','265','MIN:0'),('MIN | Detector 2','<?=$270_threMinID2?>','270','MIN:0'),('MIN | Detector 3','<?=$275_threMinID3?>','275','MIN:0'),('MIN | Detector 4','<?=$280_threMinID4?>','280','MIN:0'),('MIN | Detector 5','<?=$285_threMinID5?>','285','MIN:0'),('MIN | Detector 6','<?=$290_threMinID6?>','290','MIN:0'),('MAX | Detector 1','<?=$266_threMaxID1?>','266','MAX:9'),('MAX | Detector 2','<?=$271_threMaxID2?>','271','MAX:9'),('MAX | Detector 3','<?=$276_threMaxID3?>','276','MAX:9'),('MAX | Detector 4','<?=$281_threMaxID4?>','281','MAX:9'),('MAX | Detector 5','<?=$286_threMaxID5?>','286','MAX:9'),('MAX | Detector 6','<?=$291_threMaxID6?>','291','MAX:9');
/*!40000 ALTER TABLE `DetectorDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Detectors`
--

DROP TABLE IF EXISTS `Detectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Detectors` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  `InputSource` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Detectors`
--

LOCK TABLES `Detectors` WRITE;
/*!40000 ALTER TABLE `Detectors` DISABLE KEYS */;
INSERT INTO `Detectors` VALUES (1,'Lane1DetectorType','DTL1_PRESENCE','radio',NULL,1),(2,'Lane1DetectorThreshold','0','text',1,1),(3,'Lane1DetectorName','Order Point 1','hidden',0,1),(4,'Lane2DetectorType','DTL2_PRESENCE','radio',NULL,8),(5,'Lane2DetectorThreshold','0','text',1,8),(6,'Lane2DetectorName','Not Fitted','hidden',0,8);
/*!40000 ALTER TABLE `Detectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetectorsParams`
--

DROP TABLE IF EXISTS `DetectorsParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DetectorsParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetectorsParams`
--

LOCK TABLES `DetectorsParams` WRITE;
/*!40000 ALTER TABLE `DetectorsParams` DISABLE KEYS */;
INSERT INTO `DetectorsParams` VALUES ('Lane1DetectorThreshold','MIN_INT_VALUE','0',NULL),('Lane1DetectorThreshold','MAX_INT_VALUE','9',NULL),('Lane2DetectorThreshold','MIN_INT_VALUE','0',NULL),('Lane2DetectorThreshold','MAX_INT_VALUE','9',NULL),('Lane1DetectorType','DTL1_PULSE','0','1'),('Lane1DetectorType','DTL1_PRESENCE','1','2'),('Lane2DetectorType','DTL2_PULSE','0','1'),('Lane2DetectorType','DTL2_PRESENCE','1','2');
/*!40000 ALTER TABLE `DetectorsParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GRD`
--

DROP TABLE IF EXISTS `GRD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GRD` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `StartTime` text,
  `EndTime` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GRD`
--

LOCK TABLES `GRD` WRITE;
/*!40000 ALTER TABLE `GRD` DISABLE KEYS */;
INSERT INTO `GRD` VALUES (1,'Breakfast','06:00','10:00'),(2,'Morning','10:00','11:00'),(3,'Lunch','11:00','14:00'),(4,'Afternoon','14:00','17:00'),(5,'Dinner','17:00','19:00'),(6,'Evening','19:00','22:00'),(7,'Night 1   ','22:00','24:00'),(8,'Night 2','00:00','02:00'),(9,'Overnight','02:00','06:00'),(10,'24 Hours','00:00','24:00'),(11,'Day Part 11','00:00','00:00'),(12,'Day Part 12 ','00:00','00:00');
/*!40000 ALTER TABLE `GRD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GRDParams`
--

DROP TABLE IF EXISTS `GRDParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GRDParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GRDParams`
--

LOCK TABLES `GRDParams` WRITE;
/*!40000 ALTER TABLE `GRDParams` DISABLE KEYS */;
/*!40000 ALTER TABLE `GRDParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Globals`
--

DROP TABLE IF EXISTS `Globals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Globals` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Globals`
--

LOCK TABLES `Globals` WRITE;
/*!40000 ALTER TABLE `Globals` DISABLE KEYS */;
INSERT INTO `Globals` VALUES (16,'ExternalAudioInGateThresholdLvl','10','text',1),(15,'ExternalAudioInRoutingMode','EAIRM_OFF','select',NULL),(14,'AutoUnmuteInHandsFreeMode','RADIO_NO','yesnoradio',NULL),(13,'OrderPointTalkWithNoVehicle','RADIO_YES','yesnoradio',NULL),(12,'PageMessagesCanCrossLanes','RADIO_YES','yesnoradio',NULL),(11,'OTInCrossLaneMode','OTICLM_2','radio',NULL),(9,'OrderPointPromptsFrench','RADIO_NO','yesnoradio',NULL),(8,'OrderPointPromptsSpanish','RADIO_NO','yesnoradio',NULL),(7,'OrderPointPromptsEnglish','RADIO_YES','yesnoradio',NULL),(6,'PullAheadPrompt','RADIO_YES','yesnoradio',NULL),(5,'StoreNowClosedPrompt','RADIO_YES','yesnoradio',NULL),(2,'PageChannelHearsOT','RADIO_NO','yesnoradio',NULL),(1,'TextAndAudioPromptsLanguage','TAAPL_ENGLISH','select',NULL),(17,'ExternalAudioMuteWhenBusy','RADIO_NO','yesnoradio',NULL),(18,'KitchenNoiseGainPlan','KNGP_OFF','radio',NULL),(10,'OrderPointPromptsGerman','RADIO_NO','yesnoradio',NULL),(19,'HapticAlertsOnHeadsets','RADIO_YES','yesnoradio',NULL),(20,'BlueLEDAlertsOnHeadsets','RADIO_YES','yesnoradio',NULL);
/*!40000 ALTER TABLE `Globals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GlobalsParams`
--

DROP TABLE IF EXISTS `GlobalsParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GlobalsParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GlobalsParams`
--

LOCK TABLES `GlobalsParams` WRITE;
/*!40000 ALTER TABLE `GlobalsParams` DISABLE KEYS */;
INSERT INTO `GlobalsParams` VALUES ('TextAndAudioPromptsLanguage','TAAPL_ENGLISH','0','1'),('TextAndAudioPromptsLanguage','TAAPL_SPANISH','1','2'),('TextAndAudioPromptsLanguage','TAAPL_FRENCH','2','3'),('TextAndAudioPromptsLanguage','TAAPL_GERMAN','3','4'),('ExternalAudioInRoutingMode','EAIRM_OFF','0','1'),('ExternalAudioInRoutingMode','EAIRM_GATE','1','2'),('ExternalAudioInRoutingMode','EAIRM_ON','2','3'),('GenericRadioYesNo','RADIO_YES','1','1'),('GenericRadioYesNo','RADIO_NO','0','2'),('OTInCrossLaneMode','OTICLM_1','1','1'),('OTInCrossLaneMode','OTICLM_2','2','2'),('KitchenNoiseGainPlan','KNGP_DYNAMIC','dynamic','1'),('KitchenNoiseGainPlan','KNGP_OFF','off','2'),('ExternalAudioInGateThresholdLvl','MIN_INT_VALUE','0',NULL),('ExternalAudioInGateThresholdLvl','MAX_INT_VALUE','100',NULL);
/*!40000 ALTER TABLE `GlobalsParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Headsets`
--

DROP TABLE IF EXISTS `Headsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Headsets` (
  `ID` int(11) NOT NULL,
  `SerialNumber` varchar(45) DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `SoftwareVersion` varchar(45) DEFAULT NULL,
  `InactiveDays` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Headsets`
--

LOCK TABLES `Headsets` WRITE;
/*!40000 ALTER TABLE `Headsets` DISABLE KEYS */;
INSERT INTO `Headsets` VALUES (1,'0804670','Headset 4670','0.0',2),(2,'0805441','Headset 5441','0.0',1),(3,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(4,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(5,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(6,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(7,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(8,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(9,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(10,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(11,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(12,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(13,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(14,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(15,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(16,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(17,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(18,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(19,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(20,'XXXXXXX','XXXXXXXXXXXX','0.0',0);
/*!40000 ALTER TABLE `Headsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HeadsetsEmpty`
--

DROP TABLE IF EXISTS `HeadsetsEmpty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HeadsetsEmpty` (
  `ID` int(11) NOT NULL,
  `SerialNumber` varchar(45) DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `SoftwareVersion` varchar(45) DEFAULT NULL,
  `InactiveDays` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HeadsetsEmpty`
--

LOCK TABLES `HeadsetsEmpty` WRITE;
/*!40000 ALTER TABLE `HeadsetsEmpty` DISABLE KEYS */;
INSERT INTO `HeadsetsEmpty` VALUES (1,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(2,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(3,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(4,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(5,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(6,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(7,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(8,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(9,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(10,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(11,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(12,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(13,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(14,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(15,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(16,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(17,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(18,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(19,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(20,'XXXXXXX','XXXXXXXXXXXX','0.0',0);
/*!40000 ALTER TABLE `HeadsetsEmpty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Headsets_Backup`
--

DROP TABLE IF EXISTS `Headsets_Backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Headsets_Backup` (
  `ID` int(11) NOT NULL,
  `SerialNumber` varchar(45) DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `SoftwareVersion` varchar(45) DEFAULT NULL,
  `InactiveDays` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Headsets_Backup`
--

LOCK TABLES `Headsets_Backup` WRITE;
/*!40000 ALTER TABLE `Headsets_Backup` DISABLE KEYS */;
INSERT INTO `Headsets_Backup` VALUES (1,'0804670','Headset 4670','0.0',0),(2,'0805441','Headset 5441','0.0',4),(3,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(4,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(5,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(6,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(7,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(8,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(9,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(10,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(11,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(12,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(13,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(14,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(15,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(16,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(17,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(18,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(19,'XXXXXXX','XXXXXXXXXXXX','0.0',0),(20,'XXXXXXX','XXXXXXXXXXXX','0.0',0);
/*!40000 ALTER TABLE `Headsets_Backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Holidays`
--

DROP TABLE IF EXISTS `Holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Holidays` (
  `HolDayID` int(11) NOT NULL,
  `DayValue` varchar(5) NOT NULL,
  `OpenTimeValue` varchar(5) NOT NULL,
  `CloseTimeValue` varchar(5) NOT NULL,
  PRIMARY KEY (`HolDayID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Holidays`
--

LOCK TABLES `Holidays` WRITE;
/*!40000 ALTER TABLE `Holidays` DISABLE KEYS */;
INSERT INTO `Holidays` VALUES (1,'1-1','00:00','00:00'),(2,'0-0','00:00','00:00'),(3,'0-0','00:00','00:00'),(4,'0-0','00:00','00:00'),(5,'0-0','00:00','00:00'),(6,'0-0','00:00','00:00'),(7,'0-0','00:00','00:00'),(8,'0-0','00:00','00:00'),(9,'0-0','00:00','00:00'),(10,'0-0','00:00','00:00'),(11,'0-0','00:00','00:00'),(12,'0-0','00:00','00:00');
/*!40000 ALTER TABLE `Holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InstallerOptions`
--

DROP TABLE IF EXISTS `InstallerOptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InstallerOptions` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InstallerOptions`
--

LOCK TABLES `InstallerOptions` WRITE;
/*!40000 ALTER TABLE `InstallerOptions` DISABLE KEYS */;
INSERT INTO `InstallerOptions` VALUES (1,'UseCustomMessage','RADIO_NO','yesnoradio',NULL),(2,'CustomMessage','                     Custom Message','text',2),(3,'NumberOfBaseStations','BASESTN_2','radio',NULL),(4,'SpecialMode','1','text',NULL);
/*!40000 ALTER TABLE `InstallerOptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InstallerOptionsParams`
--

DROP TABLE IF EXISTS `InstallerOptionsParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InstallerOptionsParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InstallerOptionsParams`
--

LOCK TABLES `InstallerOptionsParams` WRITE;
/*!40000 ALTER TABLE `InstallerOptionsParams` DISABLE KEYS */;
INSERT INTO `InstallerOptionsParams` VALUES ('CustomMessage','MAX_LENGTH','35',NULL),('NumberOfBaseStations','BASESTN_1','1','1'),('NumberOfBaseStations','BASESTN_2','2','2'),('GenericRadioYesNo','RADIO_YES','1','1'),('GenericRadioYesNo','RADIO_NO','0','2');
/*!40000 ALTER TABLE `InstallerOptionsParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KitchenNoiseActive`
--

DROP TABLE IF EXISTS `KitchenNoiseActive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KitchenNoiseActive` (
  `EntryID` int(11) NOT NULL,
  `KitchenNoiseGainActive` varchar(10) NOT NULL,
  `BadHeadsetID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`EntryID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KitchenNoiseActive`
--

LOCK TABLES `KitchenNoiseActive` WRITE;
/*!40000 ALTER TABLE `KitchenNoiseActive` DISABLE KEYS */;
INSERT INTO `KitchenNoiseActive` VALUES (1,'0','');
/*!40000 ALTER TABLE `KitchenNoiseActive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LTM`
--

DROP TABLE IF EXISTS `LTM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LTM` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LTM`
--

LOCK TABLES `LTM` WRITE;
/*!40000 ALTER TABLE `LTM` DISABLE KEYS */;
INSERT INTO `LTM` VALUES (5,'DLM','DLM_SPLIT','radio',NULL),(6,'OPVM','OPVM_DAY','radio',NULL);
/*!40000 ALTER TABLE `LTM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LTMParams`
--

DROP TABLE IF EXISTS `LTMParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LTMParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LTMParams`
--

LOCK TABLES `LTMParams` WRITE;
/*!40000 ALTER TABLE `LTMParams` DISABLE KEYS */;
INSERT INTO `LTMParams` VALUES ('TimeZone','TZ_IntDateLine','1',1),('DLM','DLM_SPLIT','SPLIT',1),('DLM','DLM_CROSS','CROSS',2),('OPVM','OPVM_DAY','DAY',NULL),('OPVM','OPVM_NIGHT','NIGHT',NULL),('TimeZone','TZ_Samoa','2',2),('TimeZone','TZ_Hawaii','3',3),('TimeZone','TZ_Alaska','4',4),('TimeZone','TZ_PacificTime','5',5),('TimeZone','TZ_MountainTime','6',6),('TimeZone','TZ_CentralTime','7',7),('TimeZone','TZ_EasternTime','8',8),('TimeZone','TZ_AtlanticTime','9',9),('TimeZone','TZ_Newfoundland','10',10),('TimeZone','TZ_BuenosAires','11',11),('TimeZone','TZ_MidAtlantic','12',12),('TimeZone','TZ_Azores','13',13),('TimeZone','TZ_London','14',14),('TimeZone','TZ_Paris','15',15),('TimeZone','TZ_Cairo','16',16),('TimeZone','TZ_Moscow','17',17),('TimeZone','TZ_Tehran','18',18),('TimeZone','TZ_AbuDhabi','19',19),('TimeZone','TZ_Kabul','20',20),('TimeZone','TZ_Karachi','21',21),('TimeZone','TZ_NewDelhi','22',22),('TimeZone','TZ_Kathmandu','23',23),('TimeZone','TZ_Novosibirsk','24',24),('TimeZone','TZ_Rangoon','25',25),('TimeZone','TZ_Bangkok','26',26),('TimeZone','TZ_HongKong','27',27),('TimeZone','TZ_Tokyo','28',28),('TimeZone','TZ_Adelaide','29',29),('TimeZone','TZ_Sydney','30',30),('TimeZone','TZ_NewCaledonia','31',31),('TimeZone','TZ_Fiji','32',32),('TimeZone','TZ_NukuAlofa','33',33),('TimeZone','TZ_NotSpecified','0',0);
/*!40000 ALTER TABLE `LTMParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangAbout`
--

DROP TABLE IF EXISTS `LangAbout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangAbout` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangAbout`
--

LOCK TABLES `LangAbout` WRITE;
/*!40000 ALTER TABLE `LangAbout` DISABLE KEYS */;
INSERT INTO `LangAbout` VALUES ('en_us','PageTitle','REVISION INFORMATION'),('en_us','ClientIpAddress','Client IP address'),('en_us','ServerIpAddress','Server IP address'),('en_us','HardwareRevisionLevels','Hardware Revision Levels'),('en_us','SerialNoChangable','Serial# (Changable)'),('en_us','SerialNoPermanent','Serial# (Permanent)'),('en_us','BaseStationHardware','Base Station Hardware'),('en_us','SystemRevision','System Software'),('en_us','BBCSoftware','BBC Software'),('en_us','DSPSoftware','DSP Software'),('en_us','AppSoftware','Application Software'),('en_us','WebServer','Web Server'),('en_us','BBCBuildDateTime','BBC Build Date/Time'),('en_us','MSPSoftware','MSP Software'),('en_us','Database','MySQL Database Server'),('en_us','NoiseReduction','Noise Reduction'),('en_us','SoftwareRevisionLevels','Software Revision Levels');
/*!40000 ALTER TABLE `LangAbout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangAdvIO`
--

DROP TABLE IF EXISTS `LangAdvIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangAdvIO` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangAdvIO`
--

LOCK TABLES `LangAdvIO` WRITE;
/*!40000 ALTER TABLE `LangAdvIO` DISABLE KEYS */;
INSERT INTO `LangAdvIO` VALUES ('en_us','PageTitle','DIGITAL IO'),('en_us','ApplyChanges','Apply Changes'),('en_us','0','IN'),('en_us','1','OUT'),('en_us','IOPrefix','IO #'),('en_us','RelayPrefix','Relay'),('en_us','UNUSED','Unused'),('en_us','OT_MODE','ORDER TAKING'),('en_us','EXT_MSG','EXT_MSG'),('en_us','VEHAPP1','VEH_APP_1'),('en_us','VEHDET1','VEH_DET_1'),('en_us','VEHDET2','VEH_DET_2'),('en_us','TALK1','TALK1'),('en_us','TALK2','TALK2'),('en_us','PAGE1','PAGE1'),('en_us','PAGE2','PAGE2'),('en_us','GRTCNCL1','GRT_CNCL_1'),('en_us','GRTCNCL2','GRT_CNCL_2'),('en_us','IO1','Dig IO 01'),('en_us','IO2','Dig IO 02'),('en_us','IO3','Dig IO 03'),('en_us','IO4','Dig IO 04'),('en_us','IO5','Dig IO 05'),('en_us','IO6','Dig IO 06'),('en_us','IO7','Dig IO 07'),('en_us','IO8','Dig IO 08'),('en_us','IO9','Dig IO 09'),('en_us','IO10','Dig IO 10'),('en_us','IO11','Dig IO 11'),('en_us','IO12','Dig IO 12'),('en_us','IO13','Dig IO 13'),('en_us','IO14','Dig IO 14'),('en_us','IO15','Dig IO 15'),('en_us','IO16','Dig IO 16'),('en_us','VEHAPP2','VEH_APP_2'),('en_us','SPLIT_CROSS','SPLIT/CROSS'),('en_us','DAY_NIGHT','DAY/NIGHT'),('en_us','CONFIGURE_BUTTON_TEXT','Configure...'),('en_us','ConfigPageTitle','DIGITAL IO PIN/RELAY ACTION SETUP'),('en_us','ConfigCurrentSettingHeading','Current Pin/Relay Setting'),('en_us','ConfigNewSettingHeading','New Pin/Relay Setting'),('en_us','ConfigCancelChanges','Cancel');
/*!40000 ALTER TABLE `LangAdvIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangCf`
--

DROP TABLE IF EXISTS `LangCf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangCf` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangCf`
--

LOCK TABLES `LangCf` WRITE;
/*!40000 ALTER TABLE `LangCf` DISABLE KEYS */;
INSERT INTO `LangCf` VALUES ('en_us','PageTitle','SYSTEM CONFIGURATION FILE / UPGRADE'),('en_us','LabelSendConfig','Send configuration file from Computer to BaseStation'),('en_us','LabelSelectFile','Select File'),('en_us','SendFileButton','Send FIle'),('en_us','LabelReceiveConfig','Retrieve configuration file from BaseStation to Computer'),('en_us','LabelObtainCurrentSetup','Obtain current System setup'),('en_us','ReceiveFileButton','Retrieve File'),('en_us','LabelTBUpgrade','Send UPGRADE file from Computer to BaseStation'),('en_us','LabelTBFile','Select UPGRADE file'),('en_us','UpgradeFileButton','Upload Upgrade'),('en_us','LabelTBFreeSpace','max. file size in bytes'),('en_us','UpgradeInProgress','In progress');
/*!40000 ALTER TABLE `LangCf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangCloudSettings`
--

DROP TABLE IF EXISTS `LangCloudSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangCloudSettings` (
  `language` varchar(20) NOT NULL,
  `textID` varchar(40) NOT NULL,
  `text` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangCloudSettings`
--

LOCK TABLES `LangCloudSettings` WRITE;
/*!40000 ALTER TABLE `LangCloudSettings` DISABLE KEYS */;
INSERT INTO `LangCloudSettings` VALUES ('en_us','PageTitle','Cloud Configuration'),('en_us','CloudAddressTitle','Cloud Address'),('en_us','CloudAddressPortTitle','Cloud Port'),('en_us','CloudEnabledTitle','Enabled'),('en_us','ApplyChanges','Apply Changes'),('en_us','CloudUsername',''),('en_us','CloudPassword',''),('en_us','CloudUsernameTitle','Username'),('en_us','CloudPasswordTitle','Password'),('en_us','CloudStatusTitle','Connection Status');
/*!40000 ALTER TABLE `LangCloudSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangDetectors`
--

DROP TABLE IF EXISTS `LangDetectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangDetectors` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangDetectors`
--

LOCK TABLES `LangDetectors` WRITE;
/*!40000 ALTER TABLE `LangDetectors` DISABLE KEYS */;
INSERT INTO `LangDetectors` VALUES ('en_us','PageTitle','DETECTOR SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','Lane1Header','Lane 1'),('en_us','Lane2Header','Lane 2'),('en_us','Lane1DetectorType','Lane 1 Type'),('en_us','Lane1DetectorThreshold','Lane 1 Delay'),('en_us','DTL1_PRESENCE','Presence'),('en_us','DTL1_PULSE','Pulse'),('en_us','Lane2DetectorType','Lane 2 Type'),('en_us','Lane2DetectorThreshold','Lane 2 Delay'),('en_us','DTL2_PRESENCE','Presence'),('en_us','DTL2_PULSE','Pulse');
/*!40000 ALTER TABLE `LangDetectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangGRD`
--

DROP TABLE IF EXISTS `LangGRD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangGRD` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangGRD`
--

LOCK TABLES `LangGRD` WRITE;
/*!40000 ALTER TABLE `LangGRD` DISABLE KEYS */;
INSERT INTO `LangGRD` VALUES ('en_us','PageTitle','MESSAGE DAYPART DEFINITIONS'),('en_us','ApplyChanges','Apply Changes'),('en_us','DayPartName','Daypart Name'),('en_us','StartTime','Start Time'),('en_us','EndTime','End Time');
/*!40000 ALTER TABLE `LangGRD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangGlobals`
--

DROP TABLE IF EXISTS `LangGlobals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangGlobals` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangGlobals`
--

LOCK TABLES `LangGlobals` WRITE;
/*!40000 ALTER TABLE `LangGlobals` DISABLE KEYS */;
INSERT INTO `LangGlobals` VALUES ('en_us','PageTitle','GLOBAL SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','SelectHere','-- Select here --'),('en_us','TextAndAudioPromptsLanguage','Text and Audio Prompts Language'),('en_us','PageChannelHearsOT','\'PAGE\' Channel Heard by Order Taker ?'),('en_us','StoreNowClosedPrompt','\'Store Is Now Closed\'  Prompt ?'),('en_us','PullAheadPrompt','\'Pull Ahead\' Prompt ?'),('en_us','OrderPointPromptsEnglish','OrderPoint Prompts in English ?'),('en_us','OrderPointPromptsSpanish','OrderPoint Prompts in Spanish ?'),('en_us','OrderPointPromptsFrench','OrderPoint Prompts in French ?'),('en_us','OrderPointPromptsGerman','OrderPoint Prompts in German ?'),('en_us','OTInCrossLaneMode','Order Takers in CROSS Lane Mode ?'),('en_us','PageMessagesCanCrossLanes','\'PAGE\' Messages Can Cross Lanes ?'),('en_us','OrderPointTalkWithNoVehicle','Order Point TALK with no vehicle present ?'),('en_us','AutoUnmuteInHandsFreeMode','Auto Unmute HS microphone in HandsFree mode ?'),('en_us','ExternalAudioInRoutingMode','External Audio In Routing Mode ?'),('en_us','ExternalAudioInGateThresholdLvl','External Audio In Gate Threshold Level'),('en_us','ExternalAudioMuteWhenBusy','Mute External Audio In When Busy ?'),('en_us','KitchenNoiseGainPlan','Kitchen Noise Gain Plan ?'),('en_us','TAAPL_ENGLISH','ENGLISH'),('en_us','TAAPL_SPANISH','SPANISH'),('en_us','TAAPL_FRENCH','FRENCH'),('en_us','TAAPL_GERMAN','GERMAN'),('en_us','EAIRM_GATE','GATE'),('en_us','EAIRM_OFF','OFF'),('en_us','EAIRM_ON','ON'),('en_us','RADIO_YES','Yes'),('en_us','RADIO_NO','No'),('en_us','OTICLM_1','1'),('en_us','OTICLM_2','2'),('en_us','KNGP_DYNAMIC','Dynamic'),('en_us','KNGP_OFF','Off'),('en_us','HapticAlertsOnHeadsets','Haptic Alerts on Headsets '),('en_us','BlueLEDAlertsOnHeadsets','Blue LED Alerts on Headsets');
/*!40000 ALTER TABLE `LangGlobals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangHeadsets`
--

DROP TABLE IF EXISTS `LangHeadsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangHeadsets` (
  `language` varchar(20) NOT NULL,
  `textID` varchar(40) NOT NULL,
  `text` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangHeadsets`
--

LOCK TABLES `LangHeadsets` WRITE;
/*!40000 ALTER TABLE `LangHeadsets` DISABLE KEYS */;
INSERT INTO `LangHeadsets` VALUES ('en_us','PageTitle','HEADSET INFORMATION'),('en_us','ApplyChanges','Apply Changes'),('en_us','SerialNumber','Serial Number'),('en_us','Name','Name'),('en_us','SoftwareVersion','Software Version'),('en_us','InactiveDays','Inactive Days'),('en_us','Clear','Clear'),('en_us','BaseStatusLabel','Base Status'),('en_us','BaseStatusCaption','Open base'),('en_us','DeRegisterHandsetLabel','De-register Handset'),('en_us','SelectHandset','Select'),('en_us','BaseStationOpen','Open'),('en_us','BaseStationClosed','Closed');
/*!40000 ALTER TABLE `LangHeadsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangHolidays`
--

DROP TABLE IF EXISTS `LangHolidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangHolidays` (
  `language` varchar(20) NOT NULL,
  `textID` varchar(40) NOT NULL,
  `text` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangHolidays`
--

LOCK TABLES `LangHolidays` WRITE;
/*!40000 ALTER TABLE `LangHolidays` DISABLE KEYS */;
INSERT INTO `LangHolidays` VALUES ('en_us','PageTitle','HOLIDAYS / EXCEPTIONS'),('en_us','DateName','Day'),('en_us','OpenName','Open'),('en_us','CloseName','Close'),('en_us','ApplyChanges','Apply Changes');
/*!40000 ALTER TABLE `LangHolidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangInstallerOptions`
--

DROP TABLE IF EXISTS `LangInstallerOptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangInstallerOptions` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangInstallerOptions`
--

LOCK TABLES `LangInstallerOptions` WRITE;
/*!40000 ALTER TABLE `LangInstallerOptions` DISABLE KEYS */;
INSERT INTO `LangInstallerOptions` VALUES ('en_us','PageTitle','INSTALLER SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','LabelFactoryReset','Factory Reset Base-station (Except Network Settings)'),('en_us','LabelLoadSettings','Load Installer Settings'),('en_us','LabelSaveSettings','Save Installer Settings'),('en_us','RADIO_FACTORY','FACTORY RESET'),('en_us','RADIO_LOAD','LOAD SETTINGS'),('en_us','RADIO_SAVE','SAVE SETTINGS'),('en_us','RADIO_YES','Yes'),('en_us','RADIO_NO','No'),('en_us','UseCustomMessage','Use Custom Tech Service Message?'),('en_us','FrenchInstall','Is This Installation In France?'),('en_us','ExecuteButton','EXECUTE'),('en_us','LabelWarning','WARNING! Please be sure of the consequences before executing any of the following'),('en_us','CustomMessage','Custom Tech Service Message'),('en_us','NumberOfBaseStations','Number of Lanes At This Site'),('en_us','BASESTN_1','1'),('en_us','BASESTN_2','2'),('en_us','SpecialMode','Special ASR Mode?');
/*!40000 ALTER TABLE `LangInstallerOptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangLTM`
--

DROP TABLE IF EXISTS `LangLTM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangLTM` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangLTM`
--

LOCK TABLES `LangLTM` WRITE;
/*!40000 ALTER TABLE `LangLTM` DISABLE KEYS */;
INSERT INTO `LangLTM` VALUES ('en_us','PageTitle','CURRENT SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','LocalTime','Local Time HH:MM:SS'),('en_us','LocalDate','Local Date YYYY/MM/DD'),('en_us','TZ_UTC','UTC'),('en_us','DLM','Dual Lane Mode'),('en_us','OPVM','Order Point Volume Mode'),('en_us','TimeZone','Time Zone'),('en_us','TZ_NotSpecified','Not Specified'),('en_us','DLM_SPLIT','Split'),('en_us','DLM_CROSS','Cross'),('en_us','OPVM_DAY','Day'),('en_us','OPVM_NIGHT','Night'),('en_us','SelectHere','-- Select here --'),('en_us','TZ_IntDateLine','GMT-12:00 Int.Date Line'),('en_us','TZ_Samoa','GMT-11:00 Samoa'),('en_us','TZ_Hawaii','GMT-10:00 Hawaii'),('en_us','TZ_Alaska','GMT-09:00 Alaska'),('en_us','TZ_PacificTime','GMT-08:00 Pacific Time'),('en_us','TZ_MountainTime','GMT-07:00 Mountain Time'),('en_us','TZ_CentralTime','GMT-06:00 Central Time'),('en_us','TZ_EasternTime','GMT-05:00 Eastern Time'),('en_us','TZ_AtlanticTime','GMT-04:00 Atlantic Time'),('en_us','TZ_Newfoundland','GMT-03:30 Newfoundland'),('en_us','TZ_BuenosAires','GMT-03:00 Buenos Aires'),('en_us','TZ_MidAtlantic','GMT-02:00 Mid-Atlantic'),('en_us','TZ_Azores','GMT-01:00 Azores'),('en_us','TZ_London','GMT 00:00 London'),('en_us','TZ_Paris','GMT+01:00 Paris'),('en_us','TZ_Cairo','GMT+02:00 Cairo'),('en_us','TZ_Moscow','GMT+03:00 Moscow'),('en_us','TZ_Tehran','GMT+03:30 Tehran'),('en_us','TZ_AbuDhabi','GMT+04:00 Abu Dhabi'),('en_us','TZ_Kabul','GMT+04:30 Kabul'),('en_us','TZ_Karachi','GMT+05:00 Karachi'),('en_us','TZ_NewDelhi','GMT+05:30 New Delhi'),('en_us','TZ_Kathmandu','GMT+05:45 Kathmandu'),('en_us','TZ_Novosibirsk','GMT+06:00 Novosibirsk'),('en_us','TZ_Rangoon','GMT+06:30 Rangoon'),('en_us','TZ_Bangkok','GMT+07:00 Bangkok'),('en_us','TZ_HongKong','GMT+08:00 Hong Kong'),('en_us','TZ_Tokyo','GMT+09:00 Tokyo'),('en_us','TZ_Adelaide','GMT+09:30 Adelaide'),('en_us','TZ_Sydney','GMT+10:00 Sydney'),('en_us','TZ_NewCaledonia','GMT+11:00 New Caledonia'),('en_us','TZ_Fiji','GMT+12:00 Fiji'),('en_us','TZ_NukuAlofa','GMT+13:00 Nuku\'alofa');
/*!40000 ALTER TABLE `LangLTM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangLocationDetails`
--

DROP TABLE IF EXISTS `LangLocationDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangLocationDetails` (
  `language` varchar(20) NOT NULL,
  `textID` varchar(40) NOT NULL,
  `text` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangLocationDetails`
--

LOCK TABLES `LangLocationDetails` WRITE;
/*!40000 ALTER TABLE `LangLocationDetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `LangLocationDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangMSG`
--

DROP TABLE IF EXISTS `LangMSG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangMSG` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangMSG`
--

LOCK TABLES `LangMSG` WRITE;
/*!40000 ALTER TABLE `LangMSG` DISABLE KEYS */;
INSERT INTO `LangMSG` VALUES ('en_us','PageTitle','GREETER MESSAGE PROPERTIES'),('en_us','ApplyChanges','Apply Changes'),('en_us','LabelGreeterInstalled','Greeter Installed?'),('en_us','LabelPlaybackDelay','Playback After Delay of'),('en_us','LabelPlaybackToHeadsets','Playback to The Headsets'),('en_us','LabelPlaybackThruMonitor','Playback Through Monitor'),('en_us','LabelToneDuringPlayback','Tone to The Headsets During Playback'),('en_us','LabelPlayRestaurantClosedMsg','Play Restaurant Closed Message'),('en_us','LabelPlayExtDetectorMessage','Play External Detector Message'),('en_us','LabelTandemPullAheadMessage','Play Tandem Pull Ahead Message'),('en_us','LabelPlaybackMode','Playback Mode'),('en_us','LabelOneStar','/ in seconds /'),('en_us','LabelTwoStars','**/ Tandem Mode, ONLY applicable for Lane 2 ! /'),('en_us','LabelMessage','Message'),('en_us','LabelName','Name'),('en_us','LabelType','Type'),('en_us','LabelDuration','Duration'),('en_us','LabelEnabled','Enabled'),('en_us','LabelSeconds','/ seconds /'),('en_us','LabelSelectHere','Select here'),('en_us','PlayExtDetMsgOff','OFF'),('en_us','PlayModeAlternating','Alternating'),('en_us','PlayModeOnceEach','Once Each'),('en_us','RADIO_YES','Yes'),('en_us','RADIO_NO','No'),('en_us','type_greeter','GREETER'),('en_us','type_alert','ALERT'),('en_us','type_closed','CLOSED'),('en_us','type_reminder','REMINDER'),('en_us','type_forward','FORWARD');
/*!40000 ALTER TABLE `LangMSG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangMSGPROPS`
--

DROP TABLE IF EXISTS `LangMSGPROPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangMSGPROPS` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangMSGPROPS`
--

LOCK TABLES `LangMSGPROPS` WRITE;
/*!40000 ALTER TABLE `LangMSGPROPS` DISABLE KEYS */;
INSERT INTO `LangMSGPROPS` VALUES ('en_us','PageTitle','Message Properties'),('en_us','ApplyChanges','Apply Changes'),('en_us','MessageLabel','Message'),('en_us','DurationLabel','Duration'),('en_us','NameLabel','Name'),('en_us','TypeLabel','Type'),('en_us','EnabledLabel','Enabled'),('en_us','PlayToMonitorLabel','Play To Monitor'),('en_us','PriorityLabel','Priority'),('en_us','DelayLabel','Delay'),('en_us','RepeatIntervalLabel','Repeat Interval'),('en_us','RepeatCountLabel','Repeat Count'),('en_us','PlayRecordActionLabel','Record/Play Action'),('en_us','OpenPlayRecordControlCaption','Open Play/Record Control'),('en_us','PlayToHeadsetsLabel','Play to Headsets'),('en_us','HeadsetLabel','Headset Name'),('en_us','PlayToHeadsetLabel','Play to Headset'),('en_us','TuesdayDayPartsLabel','Tuesday dayparts in which this message plays'),('en_us','WednesdayDayPartsLabel','Wednesday dayparts in which this message plays'),('en_us','ThursdayDayPartsLabel','Thursday dayparts in which this message plays'),('en_us','MondayDayPartsLabel','Monday dayparts in which this message plays'),('en_us','FridayDayPartsLabel','Friday dayparts in which this message plays'),('en_us','SaturdayDayPartsLabel','Saturday dayparts in which this message plays'),('en_us','SundayDayPartsLabel','Sunday dayparts in which this message plays'),('en_us','MondayLabel','Monday'),('en_us','TuesdayLabel','Tuesday'),('en_us','WednesdayLabel','Wednesday'),('en_us','ThursdayLabel','Thursday'),('en_us','FridayLabel','Friday'),('en_us','SaturdayLabel','Saturday'),('en_us','SundayLabel','Sunday'),('en_us','RADIO_YES','Yes'),('en_us','RADIO_NO','No'),('en_us','type_alert','ALERT'),('en_us','type_reminder','REMINDER'),('en_us','type_greeter','GREETER'),('en_us','type_closed','CLOSED'),('en_us','type_forward','FORWARD'),('en_us','MessagePlaysLabel','Message Plays'),('en_us','type_null','NULL');
/*!40000 ALTER TABLE `LangMSGPROPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangMenu`
--

DROP TABLE IF EXISTS `LangMenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangMenu` (
  `language` varchar(20) NOT NULL,
  `textID` varchar(40) NOT NULL,
  `text` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangMenu`
--

LOCK TABLES `LangMenu` WRITE;
/*!40000 ALTER TABLE `LangMenu` DISABLE KEYS */;
INSERT INTO `LangMenu` VALUES ('en_us','SiteMenuTitle','Site'),('en_us','SiteItemSiteInfo','Site Information'),('en_us','SiteItemWorkingHours','Working Hours'),('en_us','SiteItemHolidaySchedule','Holiday Schedule'),('en_us','SiteItemRevisions','Revisions'),('en_us','StatusMenuTitle','Status and Support'),('en_us','StatusItemCurrent','Current'),('en_us','StatusItemDiagnostics','Diagnostics'),('en_us','StatusItemRestartSystem','Restart System'),('en_us','StatusItemInstallerOptions','Installer Options'),('en_us','SettingsMenuTitle','System Settings'),('en_us','SettingsVolCBTitle','Volume'),('en_us','SettingsItemNR','Noise Reduction'),('en_us','SettingsItemGlobal','Global'),('en_us','SettingsItemOrderTaking','OrderTaking'),('en_us','SettingsItemSelfMonitor','Self-monitoring'),('en_us','SettingsItemNetwork','Network Set-up'),('en_us','SettingsItemVoIP','VoIP Set-up'),('en_us','SettingsItemCloud','Cloud Set-up'),('en_us','SettingsVolCBDriveThru','Drive-thru Volume'),('en_us','SettingsVolCBMonitor','Monitor Volume'),('en_us','SettingsVolCBNight','Night Volume'),('en_us','OtherHWMenuTitle','Other Hardware'),('en_us','OtherHWItemHeadset','Headset'),('en_us','OtherHWGreeterCBTitle','Greeter'),('en_us','OtherHWGreeterCBGlobal','Greeter Global'),('en_us','OtherHWGreeterCBDayparts','Greeter Dayparts'),('en_us','OtherHWGreeterCBMSG_1','Msg#1'),('en_us','OtherHWGreeterCBMSG_2','Msg#2'),('en_us','OtherHWGreeterCBMSG_3','Msg#3'),('en_us','OtherHWGreeterCBMSG_4','Msg#4'),('en_us','OtherHWGreeterCBMSG_5','Msg#5'),('en_us','OtherHWGreeterCBMSG_6','Msg#6'),('en_us','OtherHWGreeterCBMSG_7','Msg#7'),('en_us','OtherHWGreeterCBMSG_8','Msg#8'),('en_us','OtherHWGreeterCBMSG_9','Msg#9'),('en_us','OtherHWGreeterCBMSG_10','Msg#10'),('en_us','OtherHWGreeterCBMSG_11','Msg#11'),('en_us','OtherHWGreeterCBMSG_12','Msg#12'),('en_us','OtherHWGreeterCBMSG_13','Msg#13'),('en_us','OtherHWGreeterCBMSG_14','Msg#14'),('en_us','OtherHWGreeterCBMSG_15','Msg#15'),('en_us','OtherHWGreeterCBMSG_16','Msg#16'),('en_us','OtherHWItemExternalTrigger','External Triggers'),('en_us','FileMenuTitle','File'),('en_us','FileItemConfig','Configuration'),('en_us','SettingsItemDetectors','Detectors');
/*!40000 ALTER TABLE `LangMenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangMonitorVolume`
--

DROP TABLE IF EXISTS `LangMonitorVolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangMonitorVolume` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangMonitorVolume`
--

LOCK TABLES `LangMonitorVolume` WRITE;
/*!40000 ALTER TABLE `LangMonitorVolume` DISABLE KEYS */;
INSERT INTO `LangMonitorVolume` VALUES ('en_us','PageTitle','MONITOR VOLUME SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','LabelType','Type'),('en_us','LabelVolume','Volume'),('en_us','LabelState','State'),('en_us','InboundListen','Inbound Listen'),('en_us','RADIO_ON','On'),('en_us','RADIO_OFF','Off'),('en_us','OutboundTalk','Outbound Talk'),('en_us','VehiclePresent','Vehicle Present'),('en_us','VehicleApproach','Vehicle Approach'),('en_us','PageMessages','Page Messages'),('en_us','ExternalAudioIn','External Audio In'),('en_us','DL2Mix','Lane Monitor Outputs'),('en_us','GreeterMessages','Greeter Messages'),('en_us','Lane1Header','Lane 1'),('en_us','Lane2Header','Lane 2'),('en_us','NotApplic','N/A'),('en_us','RADIO_MIXED','Mixed'),('en_us','RADIO_SEPARATE','Separate');
/*!40000 ALTER TABLE `LangMonitorVolume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangMonitoring`
--

DROP TABLE IF EXISTS `LangMonitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangMonitoring` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangMonitoring`
--

LOCK TABLES `LangMonitoring` WRITE;
/*!40000 ALTER TABLE `LangMonitoring` DISABLE KEYS */;
INSERT INTO `LangMonitoring` VALUES ('en_us','PageTitle','SELF MONITORING SET-UP'),('en_us','ApplyChanges','Apply Changes'),('en_us','SelectHere','-- Select here --'),('en_us','SME','Self Monitoring Enabled ?'),('en_us','RADIO_YES','Yes'),('en_us','RADIO_NO','No'),('en_us','RES','Resend Error Reports'),('en_us','RES_NEVER','Never'),('en_us','RES_EVERY_DAY','Every Day'),('en_us','RES_EVERY_WEEK','Every Week'),('en_us','RES_EVERY_MONTH','Every Month'),('en_us','NOIDA','Number Of Inactive Days Allowed');
/*!40000 ALTER TABLE `LangMonitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangNetworkSettings`
--

DROP TABLE IF EXISTS `LangNetworkSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangNetworkSettings` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangNetworkSettings`
--

LOCK TABLES `LangNetworkSettings` WRITE;
/*!40000 ALTER TABLE `LangNetworkSettings` DISABLE KEYS */;
INSERT INTO `LangNetworkSettings` VALUES ('en_us','PageTitle','NETWORK SETUP'),('en_us','ApplyChanges','Apply Changes'),('en_us','MACAddress','MAC Address'),('en_us','IPAddress','IP Address'),('en_us','SubnetMask','Subnet Mask'),('en_us','DefaultGateway','Default Gateway'),('en_us','WebServerPort','Web Server Port Number'),('en_us','RADIO_YES','Yes'),('en_us','RADIO_NO','No'),('en_us','WebServerEnabled','Web Server Enabled?'),('en_us','StaticDHCP','Static or DHCP');
/*!40000 ALTER TABLE `LangNetworkSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangNightVolume`
--

DROP TABLE IF EXISTS `LangNightVolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangNightVolume` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangNightVolume`
--

LOCK TABLES `LangNightVolume` WRITE;
/*!40000 ALTER TABLE `LangNightVolume` DISABLE KEYS */;
INSERT INTO `LangNightVolume` VALUES ('en_us','PageTitle','NIGHT VOLUME SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','TalkVol','Day Outbound Talk Volume'),('en_us','ReduceDriveThruVolBy','Reduce DriveThru Volume at Night by'),('en_us','Lane1Header','Lane 1'),('en_us','Lane2Header','Lane 2');
/*!40000 ALTER TABLE `LangNightVolume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangNoiseReduction`
--

DROP TABLE IF EXISTS `LangNoiseReduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangNoiseReduction` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangNoiseReduction`
--

LOCK TABLES `LangNoiseReduction` WRITE;
/*!40000 ALTER TABLE `LangNoiseReduction` DISABLE KEYS */;
INSERT INTO `LangNoiseReduction` VALUES ('en_us','PageTitle','NOISE REDUCTION SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','SelectHere','-- Select here --'),('en_us','IMNRL_Off','OFF'),('en_us','IMNRL_Maximum','MAXIMUM'),('en_us','IMNRL_Minimum','MINIMUM'),('en_us','IMNRL_Low','LOW'),('en_us','IMNRL_Medium','MEDIUM'),('en_us','IMNRL_High','HIGH'),('en_us','AEC_Off','OFF'),('en_us','AEC_Minimum','MINIMUM'),('en_us','AEC_Low','LOW'),('en_us','AEC_Medium','MEDIUM'),('en_us','AEC_Maximum','MAXIMUM'),('en_us','IMNRL','Inbound Microphone Noise Reduction Level'),('en_us','AEC','Acoustic Echo Canceller'),('en_us','Lane1Header','Lane 1'),('en_us','Lane2Header','Lane 2');
/*!40000 ALTER TABLE `LangNoiseReduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangOrderTaking`
--

DROP TABLE IF EXISTS `LangOrderTaking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangOrderTaking` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangOrderTaking`
--

LOCK TABLES `LangOrderTaking` WRITE;
/*!40000 ALTER TABLE `LangOrderTaking` DISABLE KEYS */;
INSERT INTO `LangOrderTaking` VALUES ('en_us','PageTitle','ORDER TAKING SETUP'),('en_us','ApplyChanges','Apply Changes'),('en_us','SelectHere','-- Select here --'),('en_us','SelectedMode','Selected Mode'),('en_us','MLPTT','Manual Listen / Push To Talk'),('en_us','MLMLT','Manual Listen / Manual Latching Tallk'),('en_us','ALTPTT','Auto Listen / Push To Talk'),('en_us','ALMLT','Auto Listen / Manual Latching Talk'),('en_us','HandsFree','Hands Free'),('en_us','Outside','Outside'),('en_us','AlwaysOn','Always On (Bypass Vehicle Detector)'),('en_us','DTADM','DriveThru Audio Duplex Mode'),('en_us','DTADM_FULL','Full'),('en_us','DTADM_HALF','Half'),('en_us','RADIO_YES','Yes'),('en_us','RADIO_NO','No');
/*!40000 ALTER TABLE `LangOrderTaking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangRes`
--

DROP TABLE IF EXISTS `LangRes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangRes` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangRes`
--

LOCK TABLES `LangRes` WRITE;
/*!40000 ALTER TABLE `LangRes` DISABLE KEYS */;
INSERT INTO `LangRes` VALUES ('en_us','PageTitle','RESTART SYSTEM'),('en_us','LabelWarning','WARNING! Please be sure of the consequences<br> before restarting the system!'),('en_us','LabelReboot','Reboot Base-station'),('en_us','RADIO_REBOOT','REBOOT'),('en_us','ExecuteButton','REBOOT');
/*!40000 ALTER TABLE `LangRes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangSTA`
--

DROP TABLE IF EXISTS `LangSTA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangSTA` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangSTA`
--

LOCK TABLES `LangSTA` WRITE;
/*!40000 ALTER TABLE `LangSTA` DISABLE KEYS */;
INSERT INTO `LangSTA` VALUES ('en_us','PageTitle','SYSTEM DIAGNOSTICS'),('en_us','Lane1','Lane 1'),('en_us','Lane2','Lane 2'),('en_us','Yes','Yes'),('en_us','No','No'),('en_us','DET_TEXT','DET'),('en_us','TALK_TEXT','TALK'),('en_us','PAGE_TEXT','PAGE'),('en_us','LIS_TEXT','LIS'),('en_us','REFRESH_LABEL','Refresh'),('en_us','STATUS_FLAGS_HEADING','Status Flags'),('en_us','UPTIME_HEADING','System boot information'),('en_us','DIAG_MSGS_HEADING','Diagnostics Messages');
/*!40000 ALTER TABLE `LangSTA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangTrgIn`
--

DROP TABLE IF EXISTS `LangTrgIn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangTrgIn` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangTrgIn`
--

LOCK TABLES `LangTrgIn` WRITE;
/*!40000 ALTER TABLE `LangTrgIn` DISABLE KEYS */;
INSERT INTO `LangTrgIn` VALUES ('en_us','PageTitle','ALERT MESSAGE INPUTS'),('en_us','ApplyChanges','Apply Changes'),('en_us','SelectHere','-- Select here --'),('en_us','OriginalMode','Original Mode'),('en_us','SplitCrossPin','SPLIT/CROSS Input Pin'),('en_us','OrderTakingPin','ORDER TAKING Input Pin'),('en_us','DayNightPin','DAY/NIGHT Input Pin'),('en_us','ExtMsgPin','EXT MSG Input Pin');
/*!40000 ALTER TABLE `LangTrgIn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangVoIPSettings`
--

DROP TABLE IF EXISTS `LangVoIPSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangVoIPSettings` (
  `language` varchar(20) NOT NULL,
  `textID` varchar(40) NOT NULL,
  `text` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangVoIPSettings`
--

LOCK TABLES `LangVoIPSettings` WRITE;
/*!40000 ALTER TABLE `LangVoIPSettings` DISABLE KEYS */;
INSERT INTO `LangVoIPSettings` VALUES ('en_us','PageTitle','VoIP Configuration'),('en_us','Lane1Header','Lane 1'),('en_us','Lane2Header','Lane 2'),('en_us','VoIPEnabledTitle','Enabled'),('en_us','VoIPServerTitle','Server'),('en_us','VoIPServerPortTitle','Server Port'),('en_us','VoIPRegistrarTitle','Registrar'),('en_us','VoIPRegistrarPortTitle','Registrar Port'),('en_us','VoIPExtensionTitle','Extension'),('en_us','VoIPPasswordTitle','Password'),('en_us','VoIPOutdialExtensionTitle','Outdial Extension'),('en_us','VoIPProxyEnabledTitle','Registrar as Proxy'),('en_us','ApplyChanges','Apply Changes'),('en_us','VoIPAuthenticationTitle','Authentication'),('en_us','VoIPRegStatusTitle','Registrar Status'),('en_us','VoIPCallStatusTitle','Call Status'),('en_us','VoIPOutdialOnSensorTitle','Outdial on Sensor'),('en_us','VoIPAutoAnswerCallsTitle','Auto Answer Calls');
/*!40000 ALTER TABLE `LangVoIPSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangVolume`
--

DROP TABLE IF EXISTS `LangVolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangVolume` (
  `language` varchar(20) CHARACTER SET latin1 NOT NULL,
  `textID` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangVolume`
--

LOCK TABLES `LangVolume` WRITE;
/*!40000 ALTER TABLE `LangVolume` DISABLE KEYS */;
INSERT INTO `LangVolume` VALUES ('en_us','PageTitle','DRIVE-THRU VOLUME SETTINGS'),('en_us','ApplyChanges','Apply Changes'),('en_us','MicVol','Inbound Microphone Volume'),('en_us','TalkVol','Outbound Talk Volume'),('en_us','VehicleAlertVol','Vehicle Alert Volume'),('en_us','GreeterVol','Outbound Greeter Message Volume'),('en_us','ExternalVol','External Audio In Volume'),('en_us','LabelMicPreampGain','Mic Preamp Gain (Installer only Option)'),('en_us','NotApplic','N/A'),('en_us','Lane1Header','Lane 1'),('en_us','Lane2Header','Lane 2');
/*!40000 ALTER TABLE `LangVolume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LangWorkingHours`
--

DROP TABLE IF EXISTS `LangWorkingHours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LangWorkingHours` (
  `language` varchar(20) NOT NULL,
  `textID` varchar(40) NOT NULL,
  `text` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`,`language`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LangWorkingHours`
--

LOCK TABLES `LangWorkingHours` WRITE;
/*!40000 ALTER TABLE `LangWorkingHours` DISABLE KEYS */;
INSERT INTO `LangWorkingHours` VALUES ('en_us','Mon','Monday'),('en_us','Tue','Tuesday'),('en_us','Wed','Wednesday'),('en_us','Thu','Thursday'),('en_us','Fri','Friday'),('en_us','Sat','Saturday'),('en_us','Sun','Sunday'),('en_us','CloseTime','Close Time'),('en_us','OpenTime','Open Time'),('en_us','DayTime','Day Time'),('en_us','NightTime','Night Time'),('fr_fr','Mon','Lundi'),('fr_fr','Tue','Mardi'),('fr_fr','Wed','Mercredi'),('fr_fr','Thu','Jeudi'),('fr_fr','Fri','Vendredi'),('fr_fr','Sat','Samedi'),('fr_fr','Sun','Dimanche'),('fr_fr','OpenTime','temps d\'ouverture'),('fr_fr','CloseTime','temps de fermeture'),('fr_fr','DayTime','pendant la journée'),('fr_fr','NightTime','période nocturne'),('en_us','DayOfWeek','Day of week'),('fr_fr','DayOfWeek','Jour de la sem.'),('en_us','WorkingHours','Working Hours'),('fr_fr','WorkingHours','journée de travail'),('en_us','ApplyChanges','Apply Changes'),('fr_fr','ApplyChanges','appliquer les modifications');
/*!40000 ALTER TABLE `LangWorkingHours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Languages`
--

DROP TABLE IF EXISTS `Languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Languages` (
  `ID` varchar(40) NOT NULL,
  `LanguageName` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Value_UNIQUE` (`LanguageName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Languages`
--

LOCK TABLES `Languages` WRITE;
/*!40000 ALTER TABLE `Languages` DISABLE KEYS */;
INSERT INTO `Languages` VALUES ('en_us','US English');
/*!40000 ALTER TABLE `Languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LocationDetails`
--

DROP TABLE IF EXISTS `LocationDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LocationDetails` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(40) NOT NULL,
  `Length` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LocationDetails`
--

LOCK TABLES `LocationDetails` WRITE;
/*!40000 ALTER TABLE `LocationDetails` DISABLE KEYS */;
INSERT INTO `LocationDetails` VALUES ('Store Name','<?=$002_storeName?>','002','Digac UT Lab','20'),('Store-ID','<?=$001_storeID?>','001','1','12'),('Street Address','<?=$004_streetAddress?>','004','10388 Hidden Oaks','30'),('City','<?=$005_cityName?>','005','Highland','30'),('State/Province','<?=$007_stateProvince?>','007','UT','30'),('Postal Code','<?=$006_postalCode?>','006','84003','20'),('Country','<?=$008_countryName?>','008','USA','30'),('Contact Tel. No.','<?=$003_contactTel?>','003','224-544-581','20'),('Timestamp','','2000','1365080159',NULL),('SessionID','','2001','320eee0835958c12758b3ce865259c67',NULL);
/*!40000 ALTER TABLE `LocationDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MSG`
--

DROP TABLE IF EXISTS `MSG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MSG` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MSG`
--

LOCK TABLES `MSG` WRITE;
/*!40000 ALTER TABLE `MSG` DISABLE KEYS */;
INSERT INTO `MSG` VALUES (1,'GreeterInstalled','1'),(6,'PlayRestaurantClosedMsg','0'),(3,'PlaybackToHeadsets','1'),(4,'PlaybackThruMonitor','1'),(5,'PlaybackToneDuringPlayback','0'),(2,'PlaybackDelay','0'),(7,'PlayExtDetectorMessage','0'),(8,'TandemPullAheadMessage','0'),(9,'PlaybackMode','0');
/*!40000 ALTER TABLE `MSG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ManufacturingData`
--

DROP TABLE IF EXISTS `ManufacturingData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ManufacturingData` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Value` varchar(45) DEFAULT NULL,
  `Length` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Manufacturing Data for the VENUS base';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ManufacturingData`
--

LOCK TABLES `ManufacturingData` WRITE;
/*!40000 ALTER TABLE `ManufacturingData` DISABLE KEYS */;
INSERT INTO `ManufacturingData` VALUES (1,'Hardware Version',NULL,'5'),(2,'Serial Number',NULL,'10'),(3,'ICT Flag',NULL,'1'),(4,'Function Test Flag',NULL,'1'),(5,'SAV Flag',NULL,'1'),(6,'Test Number',NULL,'2'),(7,'TB Identifier',NULL,'1'),(8,'Test Date',NULL,'6'),(9,'Test Version',NULL,'2');
/*!40000 ALTER TABLE `ManufacturingData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Messages`
--

DROP TABLE IF EXISTS `Messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Messages` (
  `MsgID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Type` varchar(45) NOT NULL,
  `Enabled` int(1) NOT NULL,
  `PlayToMonitor` int(1) NOT NULL,
  `Priority` int(1) NOT NULL,
  `RepeatInterval` varchar(10) NOT NULL,
  `Delay` varchar(10) NOT NULL,
  `RepeatCount` int(5) NOT NULL,
  `Duration` int(5) NOT NULL,
  `HeadsetEnable` int(32) unsigned NOT NULL DEFAULT '1048575',
  `MonDayParts` smallint(16) unsigned NOT NULL DEFAULT '0',
  `TueDayParts` smallint(16) unsigned NOT NULL DEFAULT '0',
  `WedDayParts` smallint(16) unsigned NOT NULL DEFAULT '0',
  `ThuDayParts` smallint(16) unsigned NOT NULL DEFAULT '0',
  `FriDayParts` smallint(16) unsigned NOT NULL DEFAULT '0',
  `SatDayParts` smallint(16) unsigned NOT NULL DEFAULT '0',
  `SunDayParts` smallint(16) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`MsgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Messages`
--

LOCK TABLES `Messages` WRITE;
/*!40000 ALTER TABLE `Messages` DISABLE KEYS */;
INSERT INTO `Messages` VALUES (1,'Breakfast 1 ','type_greeter',1,0,0,'00:01:00','00:00',1,7,1048575,1,4,16,64,256,1024,5),(2,'Breakfast 2 ','type_greeter',0,0,0,'00:01:00','00:00',1,4,1048575,0,0,0,0,0,0,0),(3,'Lunch 1     ','type_greeter',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(4,'Lunch 2     ','type_greeter',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(5,'Evening 1   ','type_greeter',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(6,'Evening 2   ','type_greeter',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(7,'24 Hours 1  ','type_greeter',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(8,'24 Hours 2  ','type_greeter',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(9,'Forward     ','type_forward',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(10,'Closed      ','type_closed',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(11,'Hand Wash   ','type_reminder',0,0,1,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(12,'Reminder 2  ','type_reminder',0,0,1,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(13,'Reminder 3  ','type_reminder',0,0,1,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(14,'Reminder 4  ','type_reminder',0,0,1,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(15,'Cooler Open ','type_alert',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0),(16,'Door Open   ','type_alert',0,0,0,'00:01:00','00:00',1,0,1048575,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `Messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MessagesParams`
--

DROP TABLE IF EXISTS `MessagesParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MessagesParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MessagesParams`
--

LOCK TABLES `MessagesParams` WRITE;
/*!40000 ALTER TABLE `MessagesParams` DISABLE KEYS */;
INSERT INTO `MessagesParams` VALUES ('type','type_alert','ALERT','1'),('type','type_reminder','REMINDER','2'),('type','type_greeter','GREETER','3'),('type','type_closed','CLOSED','4'),('type','type_forward','FORWARD','5'),('type','type_null','NULL','6');
/*!40000 ALTER TABLE `MessagesParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Misc`
--

DROP TABLE IF EXISTS `Misc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Misc` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(80) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Misc`
--

LOCK TABLES `Misc` WRITE;
/*!40000 ALTER TABLE `Misc` DISABLE KEYS */;
INSERT INTO `Misc` VALUES ('Night Volume Reduction | Reduce By','<?=$739_nightVolume?>','739','MIN:0'),('Lane Settings|Lane Mode','<?=$235_lane1SplitCross?>','235','SPLIT'),('Ethernet MAC Address','<?=$162_addressMAC?>','162','08:00:21:20:00:8C'),('Update Button','<?=$576_UPDATE_BUTTON_DEF?>','576','<input type=\"submit\" value=\"Apply Changes\">'),('Menu Bar Auto Refresh','<?=$938_menuBarAutoRefresh?>','938','0'),('Last Error Message','<?=$477_LAST_ERROR_MESSAGE?>','477','All OK'),('Last Message','<?=$9900_LAST Message?>','9900','9906'),('Current Greeter Message','<?=$9960_CurrentGreeterMessage?>','9960','9971');
/*!40000 ALTER TABLE `Misc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MonitorVolume`
--

DROP TABLE IF EXISTS `MonitorVolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MonitorVolume` (
  `ID` int(11) NOT NULL,
  `Type` varchar(45) NOT NULL,
  `Volume` varchar(45) NOT NULL,
  `State` int(1) NOT NULL,
  `MinValue` int(3) NOT NULL,
  `MaxValue` int(3) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Type_UNIQUE` (`Type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MonitorVolume`
--

LOCK TABLES `MonitorVolume` WRITE;
/*!40000 ALTER TABLE `MonitorVolume` DISABLE KEYS */;
INSERT INTO `MonitorVolume` VALUES (1,'InboundListen','10',1,0,20),(2,'OutboundTalk','2',1,0,20),(3,'VehiclePresent','2',1,0,20),(4,'VehicleApproach','10',1,0,20),(5,'PageMessages','2',1,0,20),(6,'ExternalAudioIn','10',1,0,20),(7,'GreeterMessages','10',1,0,20),(8,'DL2Mix','0',0,0,20);
/*!40000 ALTER TABLE `MonitorVolume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MonitorVolumeParams`
--

DROP TABLE IF EXISTS `MonitorVolumeParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MonitorVolumeParams` (
  `idMonitorVolumeParams` int(11) NOT NULL,
  PRIMARY KEY (`idMonitorVolumeParams`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MonitorVolumeParams`
--

LOCK TABLES `MonitorVolumeParams` WRITE;
/*!40000 ALTER TABLE `MonitorVolumeParams` DISABLE KEYS */;
/*!40000 ALTER TABLE `MonitorVolumeParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Monitoring`
--

DROP TABLE IF EXISTS `Monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Monitoring` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitoring`
--

LOCK TABLES `Monitoring` WRITE;
/*!40000 ALTER TABLE `Monitoring` DISABLE KEYS */;
INSERT INTO `Monitoring` VALUES (1,'SME','RADIO_NO','yesnoradio',NULL),(2,'RES','RES_EVERY_WEEK','select',NULL),(3,'NOIDA','30','text',1);
/*!40000 ALTER TABLE `Monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MonitoringParams`
--

DROP TABLE IF EXISTS `MonitoringParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MonitoringParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MonitoringParams`
--

LOCK TABLES `MonitoringParams` WRITE;
/*!40000 ALTER TABLE `MonitoringParams` DISABLE KEYS */;
INSERT INTO `MonitoringParams` VALUES ('GenericRadioYesNo','RADIO_YES','1','1'),('GenericRadioYesNo','RADIO_NO','0','2'),('RES','RES_NEVER','0','1'),('RES','RES_EVERY_DAY','1','2'),('RES','RES_EVERY_WEEK','2','3'),('RES','RES_EVERY_MONTH','3','4'),('NOIDA','MIN_INT_VALUE','1',NULL),('NOIDA','MAX_INT_VALUE','60',NULL);
/*!40000 ALTER TABLE `MonitoringParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NetworkSettings`
--

DROP TABLE IF EXISTS `NetworkSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NetworkSettings` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NetworkSettings`
--

LOCK TABLES `NetworkSettings` WRITE;
/*!40000 ALTER TABLE `NetworkSettings` DISABLE KEYS */;
INSERT INTO `NetworkSettings` VALUES (1,'MACAddress','AA:BB:CC:DD','displayonly',NULL),(3,'IPAddress','192.168.1.20','textdisabled',NULL),(2,'WebServerEnabled','RADIO_YES','yesnoradio',NULL),(4,'SubnetMask','255.255.255.0','textdisabled',NULL),(5,'DefaultGateway','192.168.1.1','textdisabled',NULL),(6,'WebServerPort','80','textdisabled',NULL),(7,'StaticDHCP','RADIO_NO','yesnoradio',NULL);
/*!40000 ALTER TABLE `NetworkSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NetworkSettingsParams`
--

DROP TABLE IF EXISTS `NetworkSettingsParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NetworkSettingsParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NetworkSettingsParams`
--

LOCK TABLES `NetworkSettingsParams` WRITE;
/*!40000 ALTER TABLE `NetworkSettingsParams` DISABLE KEYS */;
INSERT INTO `NetworkSettingsParams` VALUES ('GenericRadioYesNo','RADIO_YES','1','1'),('GenericRadioYesNo','RADIO_NO','0','2');
/*!40000 ALTER TABLE `NetworkSettingsParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NightVolume`
--

DROP TABLE IF EXISTS `NightVolume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NightVolume` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NightVolume`
--

LOCK TABLES `NightVolume` WRITE;
/*!40000 ALTER TABLE `NightVolume` DISABLE KEYS */;
INSERT INTO `NightVolume` VALUES (2,'ReduceDriveThruVolBy','0','text',1);
/*!40000 ALTER TABLE `NightVolume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NightVolumeParams`
--

DROP TABLE IF EXISTS `NightVolumeParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NightVolumeParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NightVolumeParams`
--

LOCK TABLES `NightVolumeParams` WRITE;
/*!40000 ALTER TABLE `NightVolumeParams` DISABLE KEYS */;
INSERT INTO `NightVolumeParams` VALUES ('ReduceDriveThruVolBy','MIN_INT_VALUE','0',''),('ReduceDriveThruVolBy','MAX_INT_VALUE','20',NULL);
/*!40000 ALTER TABLE `NightVolumeParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NoiseReduction`
--

DROP TABLE IF EXISTS `NoiseReduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NoiseReduction` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NoiseReduction`
--

LOCK TABLES `NoiseReduction` WRITE;
/*!40000 ALTER TABLE `NoiseReduction` DISABLE KEYS */;
INSERT INTO `NoiseReduction` VALUES (1,'IMNRL','IMNRL_Medium','select',NULL),(2,'AEC','AEC_Medium','select',NULL);
/*!40000 ALTER TABLE `NoiseReduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NoiseReductionParams`
--

DROP TABLE IF EXISTS `NoiseReductionParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NoiseReductionParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NoiseReductionParams`
--

LOCK TABLES `NoiseReductionParams` WRITE;
/*!40000 ALTER TABLE `NoiseReductionParams` DISABLE KEYS */;
INSERT INTO `NoiseReductionParams` VALUES ('AEC','AEC_Off','0','1'),('AEC','AEC_Minimum','1','2'),('AEC','AEC_Low','2','3'),('AEC','AEC_Medium','3','4'),('AEC','AEC_Maximum','4','5'),('IMNRL','IMNRL_Off','0','1'),('IMNRL','IMNRL_Minimum','1','2'),('IMNRL','IMNRL_Maximum','5','6'),('IMNRL','IMNRL_Low','2','3'),('IMNRL','IMNRL_Medium','3','4'),('IMNRL','IMNRL_High','4','5');
/*!40000 ALTER TABLE `NoiseReductionParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderTaking`
--

DROP TABLE IF EXISTS `OrderTaking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderTaking` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderTaking`
--

LOCK TABLES `OrderTaking` WRITE;
/*!40000 ALTER TABLE `OrderTaking` DISABLE KEYS */;
INSERT INTO `OrderTaking` VALUES (1,'SelectedMode','ALMLT','select',NULL),(2,'MLPTT','RADIO_NO','yesnoradio',NULL),(3,'MLMLT','RADIO_NO','yesnoradio',NULL),(4,'ALTPTT','RADIO_NO','yesnoradio',NULL),(5,'ALMLT','RADIO_YES','yesnoradio',NULL),(6,'HandsFree','RADIO_NO','yesnoradio',NULL),(7,'Outside','RADIO_NO','yesnoradio',NULL),(8,'AlwaysOn','RADIO_NO','yesnoradio',NULL),(9,'DTADM','DTADM_FULL','radio',NULL);
/*!40000 ALTER TABLE `OrderTaking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderTakingParams`
--

DROP TABLE IF EXISTS `OrderTakingParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderTakingParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderTakingParams`
--

LOCK TABLES `OrderTakingParams` WRITE;
/*!40000 ALTER TABLE `OrderTakingParams` DISABLE KEYS */;
INSERT INTO `OrderTakingParams` VALUES ('SelectedMode','MLPTT','0','1'),('SelectedMode','MLMLT','1','2'),('SelectedMode','ALTPTT','2','3'),('SelectedMode','ALMLT','3','4'),('SelectedMode','HandsFree','4','5'),('SelectedMode','Outside','5','6'),('SelectedMode','AlwaysOn','6','7'),('DTADM','DTADM_FULL','full','1'),('DTADM','DTADM_HALF','half','2'),('GenericRadioYesNo','RADIO_YES','1','1'),('GenericRadioYesNo','RADIO_NO','0','2');
/*!40000 ALTER TABLE `OrderTakingParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OtherVolumes`
--

DROP TABLE IF EXISTS `OtherVolumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OtherVolumes` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OtherVolumes`
--

LOCK TABLES `OtherVolumes` WRITE;
/*!40000 ALTER TABLE `OtherVolumes` DISABLE KEYS */;
INSERT INTO `OtherVolumes` VALUES (1,'MonOutputVol','5','text',1),(2,'ExtraGain','17','text',1),(3,'GRpageVol','19','text',1),(4,'GRauxVol','18','text',1),(5,'OTvehAlertVol','9','text',1),(6,'OTpageVol','8','text',1),(7,'OTopVol','7','text',1),(8,'OTmessageVol','4','text',1),(9,'BCvehAlertVol','16','text',1),(10,'BCpageVol','14','text',1),(11,'BCtalkVol','15','text',1),(12,'BCopVol','13','text',1),(13,'BCmessageVol','4','text',1),(14,'BCgreetToneVol','3','text',1),(15,'BCextAudioVol','10','text',1),(16,'OT1PostMixGain','4','text',1),(17,'OT2PostMixGain','4','text',1),(18,'BC1PostMixGain','4','text',1),(19,'BC2PostMixGain','4','text',1),(20,'EXTAUD1outVol','20','text',1),(21,'EXTAUD2outVol','20','text',1);
/*!40000 ALTER TABLE `OtherVolumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OtherVolumesKNGPoff`
--

DROP TABLE IF EXISTS `OtherVolumesKNGPoff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OtherVolumesKNGPoff` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OtherVolumesKNGPoff`
--

LOCK TABLES `OtherVolumesKNGPoff` WRITE;
/*!40000 ALTER TABLE `OtherVolumesKNGPoff` DISABLE KEYS */;
INSERT INTO `OtherVolumesKNGPoff` VALUES (1,'MonOutputVol','10','text',1),(2,'ExtraGain','0','text',1),(3,'GRpageVol','20','text',1),(4,'GRauxVol','20','text',1),(5,'OTvehAlertVol','3','text',1),(6,'OTpageVol','5','text',1),(7,'OTopVol','16','text',1),(8,'OTmessageVol','4','text',1),(9,'BCvehAlertVol','3','text',1),(10,'BCpageVol','3','text',1),(11,'BCtalkVol','3','text',1),(12,'BCopVol','16','text',1),(13,'BCmessageVol','4','text',1),(14,'BCgreetToneVol','3','text',1),(15,'BCextAudioVol','5','text',1),(16,'OT1PostMixGain','4','text',1),(17,'OT2PostMixGain','4','text',1),(18,'BC1PostMixGain','4','text',1),(19,'BC2PostMixGain','4','text',1),(20,'EXTAUD1outVol','20','text',1),(21,'EXTAUD2outVol','20','text',1);
/*!40000 ALTER TABLE `OtherVolumesKNGPoff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OtherVolumesParams`
--

DROP TABLE IF EXISTS `OtherVolumesParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OtherVolumesParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OtherVolumesParams`
--

LOCK TABLES `OtherVolumesParams` WRITE;
/*!40000 ALTER TABLE `OtherVolumesParams` DISABLE KEYS */;
INSERT INTO `OtherVolumesParams` VALUES ('MonOutputVol','MIN_INT_VALUE','1',NULL),('MonOutputVol','MAX_INT_VALUE','20',NULL),('ExtraGain','MIN_INT_VALUE','1',NULL),('ExtraGain','MAX_INT_VALUE','20',NULL),('GRpageVol','MIN_INT_VALUE','1',NULL),('GRpageVol','MAX_INT_VALUE','20',NULL),('GRauxVol','MIN_INT_VALUE','1',NULL),('GRauxVol','MAX_INT_VALUE','20',NULL),('OTvehAlertVol','MIN_INT_VALUE','1',NULL),('OTvehAlertVol','MAX_INT_VALUE','20',NULL),('OTpageVol','MIN_INT_VALUE','1',NULL),('OTpageVol','MAX_INT_VALUE','20',NULL),('OTopVol','MIN_INT_VALUE','1',NULL),('OTopVol','MAX_INT_VALUE','20',NULL),('OTmessageVol','MIN_INT_VALUE','1',NULL),('OTmessageVol','MAX_INT_VALUE','20',NULL),('BCvehAlertVol','MIN_INT_VALUE','1',NULL),('BCvehAlertVol','MAX_INT_VALUE','20',NULL),('BCpageVol','MIN_INT_VALUE','1',NULL),('BCpageVol','MAX_INT_VALUE','20',NULL),('BCtalkVol','MIN_INT_VALUE','1',NULL),('BCtalkVol','MAX_INT_VALUE','20',NULL),('BCopVol','MIN_INT_VALUE','1',NULL),('BCopVol','MAX_INT_VALUE','20',NULL),('BCmessageVol','MIN_INT_VALUE','1',NULL),('BCmessageVol','MAX_INT_VALUE','20',NULL),('BCgreetToneVol','MIN_INT_VALUE','1',NULL),('BCgreetToneVol','MAX_INT_VALUE','20',NULL),('BCextAudioVol','MIN_INT_VALUE','1',NULL),('BCextAudioVol','MAX_INT_VALUE','20',NULL),('OT1PostMixGain','MIN_INT_VALUE','0',NULL),('OT1PostMixGain','MAX_INT_VALUE','8',NULL),('OT2PostMixGain','MIN_INT_VALUE','0',NULL),('OT2PostMixGain','MAX_INT_VALUE','8',NULL),('BC1PostMixGain','MIN_INT_VALUE','0',NULL),('BC1PostMixGain','MAX_INT_VALUE','8',NULL),('BC2PostMixGain','MIN_INT_VALUE','0',NULL),('BC2PostMixGain','MAX_INT_VALUE','8',NULL),('EXTAUD1outVol','MIN_INT_VALUE','0',NULL),('EXTAUD1outVol','MAX_INT_VALUE','20',NULL),('EXTAUD2outVol','MIN_INT_VALUE','0',NULL),('EXTAUD2outVol','MAX_INT_VALUE','20',NULL);
/*!40000 ALTER TABLE `OtherVolumesParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OtherVolumesParamsKNGPoff`
--

DROP TABLE IF EXISTS `OtherVolumesParamsKNGPoff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OtherVolumesParamsKNGPoff` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OtherVolumesParamsKNGPoff`
--

LOCK TABLES `OtherVolumesParamsKNGPoff` WRITE;
/*!40000 ALTER TABLE `OtherVolumesParamsKNGPoff` DISABLE KEYS */;
/*!40000 ALTER TABLE `OtherVolumesParamsKNGPoff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PlaysOnDayPart`
--

DROP TABLE IF EXISTS `PlaysOnDayPart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PlaysOnDayPart` (
  `MsgID` int(11) NOT NULL,
  `DayPartID` int(11) NOT NULL,
  `DayOfWeekID` varchar(45) NOT NULL,
  PRIMARY KEY (`MsgID`,`DayPartID`,`DayOfWeekID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlaysOnDayPart`
--

LOCK TABLES `PlaysOnDayPart` WRITE;
/*!40000 ALTER TABLE `PlaysOnDayPart` DISABLE KEYS */;
/*!40000 ALTER TABLE `PlaysOnDayPart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PlaysOnHeadset`
--

DROP TABLE IF EXISTS `PlaysOnHeadset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PlaysOnHeadset` (
  `MsgID` int(11) NOT NULL,
  `HeadsetID` int(11) NOT NULL,
  PRIMARY KEY (`MsgID`,`HeadsetID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlaysOnHeadset`
--

LOCK TABLES `PlaysOnHeadset` WRITE;
/*!40000 ALTER TABLE `PlaysOnHeadset` DISABLE KEYS */;
INSERT INTO `PlaysOnHeadset` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),(2,16),(2,17),(2,18),(2,19),(2,20),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),(4,11),(4,12),(4,13),(4,14),(4,15),(4,16),(4,17),(4,18),(4,19),(4,20),(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),(5,11),(5,12),(5,13),(5,14),(5,15),(5,16),(5,17),(5,18),(5,19),(5,20),(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,9),(6,10),(6,11),(6,12),(6,13),(6,14),(6,15),(6,16),(6,17),(6,18),(6,19),(6,20),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9),(7,10),(7,11),(7,12),(7,13),(7,14),(7,15),(7,16),(7,17),(7,18),(7,19),(7,20),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10),(8,11),(8,12),(8,13),(8,14),(8,15),(8,16),(8,17),(8,18),(8,19),(8,20),(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),(9,8),(9,9),(9,10),(9,11),(9,12),(9,13),(9,14),(9,15),(9,16),(9,17),(9,18),(9,19),(9,20),(10,1),(10,2),(10,3),(10,4),(10,5),(10,6),(10,7),(10,8),(10,9),(10,10),(10,11),(10,12),(10,13),(10,14),(10,15),(10,16),(10,17),(10,18),(10,19),(10,20),(11,1),(11,2),(11,3),(11,4),(11,5),(11,6),(11,7),(11,8),(11,9),(11,10),(11,11),(11,12),(11,13),(11,14),(11,15),(11,16),(11,17),(11,18),(11,19),(11,20),(12,1),(12,2),(12,3),(12,4),(12,5),(12,6),(12,7),(12,8),(12,9),(12,10),(12,11),(12,12),(12,13),(12,14),(12,15),(12,16),(12,17),(12,18),(12,19),(12,20),(13,1),(13,2),(13,3),(13,4),(13,5),(13,6),(13,7),(13,8),(13,9),(13,10),(13,11),(13,12),(13,13),(13,14),(13,15),(13,16),(13,17),(13,18),(13,19),(13,20),(14,1),(14,2),(14,3),(14,4),(14,5),(14,6),(14,7),(14,8),(14,9),(14,10),(14,11),(14,12),(14,13),(14,14),(14,15),(14,16),(14,17),(14,18),(14,19),(14,20),(15,1),(15,2),(15,3),(15,4),(15,5),(15,6),(15,7),(15,8),(15,9),(15,10),(15,11),(15,12),(15,13),(15,14),(15,15),(15,16),(15,17),(15,18),(15,19),(15,20),(16,1),(16,2),(16,3),(16,4),(16,5),(16,6),(16,7),(16,8),(16,9),(16,10),(16,11),(16,12),(16,13),(16,14),(16,15),(16,16),(16,17),(16,18),(16,19),(16,20);
/*!40000 ALTER TABLE `PlaysOnHeadset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PlaysOnHeadsetDefaults`
--

DROP TABLE IF EXISTS `PlaysOnHeadsetDefaults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PlaysOnHeadsetDefaults` (
  `MsgID` int(11) NOT NULL,
  `HeadsetID` int(11) NOT NULL,
  PRIMARY KEY (`MsgID`,`HeadsetID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlaysOnHeadsetDefaults`
--

LOCK TABLES `PlaysOnHeadsetDefaults` WRITE;
/*!40000 ALTER TABLE `PlaysOnHeadsetDefaults` DISABLE KEYS */;
INSERT INTO `PlaysOnHeadsetDefaults` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),(2,16),(2,17),(2,18),(2,19),(2,20),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),(4,11),(4,12),(4,13),(4,14),(4,15),(4,16),(4,17),(4,18),(4,19),(4,20),(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),(5,11),(5,12),(5,13),(5,14),(5,15),(5,16),(5,17),(5,18),(5,19),(5,20),(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,9),(6,10),(6,11),(6,12),(6,13),(6,14),(6,15),(6,16),(6,17),(6,18),(6,19),(6,20),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9),(7,10),(7,11),(7,12),(7,13),(7,14),(7,15),(7,16),(7,17),(7,18),(7,19),(7,20),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10),(8,11),(8,12),(8,13),(8,14),(8,15),(8,16),(8,17),(8,18),(8,19),(8,20),(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),(9,8),(9,9),(9,10),(9,11),(9,12),(9,13),(9,14),(9,15),(9,16),(9,17),(9,18),(9,19),(9,20),(10,1),(10,2),(10,3),(10,4),(10,5),(10,6),(10,7),(10,8),(10,9),(10,10),(10,11),(10,12),(10,13),(10,14),(10,15),(10,16),(10,17),(10,18),(10,19),(10,20),(11,1),(11,2),(11,3),(11,4),(11,5),(11,6),(11,7),(11,8),(11,9),(11,10),(11,11),(11,12),(11,13),(11,14),(11,15),(11,16),(11,17),(11,18),(11,19),(11,20),(12,1),(12,2),(12,3),(12,4),(12,5),(12,6),(12,7),(12,8),(12,9),(12,10),(12,11),(12,12),(12,13),(12,14),(12,15),(12,16),(12,17),(12,18),(12,19),(12,20),(13,1),(13,2),(13,3),(13,4),(13,5),(13,6),(13,7),(13,8),(13,9),(13,10),(13,11),(13,12),(13,13),(13,14),(13,15),(13,16),(13,17),(13,18),(13,19),(13,20),(14,1),(14,2),(14,3),(14,4),(14,5),(14,6),(14,7),(14,8),(14,9),(14,10),(14,11),(14,12),(14,13),(14,14),(14,15),(14,16),(14,17),(14,18),(14,19),(14,20),(15,1),(15,2),(15,3),(15,4),(15,5),(15,6),(15,7),(15,8),(15,9),(15,10),(15,11),(15,12),(15,13),(15,14),(15,15),(15,16),(15,17),(15,18),(15,19),(15,20),(16,1),(16,2),(16,3),(16,4),(16,5),(16,6),(16,7),(16,8),(16,9),(16,10),(16,11),(16,12),(16,13),(16,14),(16,15),(16,16),(16,17),(16,18),(16,19),(16,20);
/*!40000 ALTER TABLE `PlaysOnHeadsetDefaults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Test123`
--

DROP TABLE IF EXISTS `Test123`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Test123` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(80) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Test123`
--

LOCK TABLES `Test123` WRITE;
/*!40000 ALTER TABLE `Test123` DISABLE KEYS */;
INSERT INTO `Test123` VALUES ('Car detector count','<?=$9950_DETECTOR_COUNT?>','9950','10');
/*!40000 ALTER TABLE `Test123` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TestAnnouncements`
--

DROP TABLE IF EXISTS `TestAnnouncements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TestAnnouncements` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(80) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TestAnnouncements`
--

LOCK TABLES `TestAnnouncements` WRITE;
/*!40000 ALTER TABLE `TestAnnouncements` DISABLE KEYS */;
INSERT INTO `TestAnnouncements` VALUES ('Back Door Open','<?=$9901_TEST_ANNOUNCEMENT_01?>','9901','/home/root/MickeyAudioSamples/Back_door_is_open.wav'),('Change Sanitizer','<?=$9902_TEST_ANNOUNCEMENT_02?>','9902','/home/root/MickeyAudioSamples/Change_Sanitizer.wav'),('Change towels','<?=$9903_TEST_ANNOUNCEMENT_03?>','9903','/home/root/MickeyAudioSamples/Change_towels.wav'),('Managers walk','<?=$9904_TEST_ANNOUNCEMENT_04?>','9904','/home/root/MickeyAudioSamples/Managers_walk.wav'),('Office Door is open','<?=$9905_TEST_ANNOUNCEMENT_05?>','9905','/home/root/MickeyAudioSamples/Office_Door_is_open.wav'),('Stir chili and sanitize your station','<?=$9906_TEST_ANNOUNCEMENT_06?>','9906','/home/root/MickeyAudioSamples/Stir_chili_and_sanatize_your_station.wav'),('Time to arm the perimeter','<?=$9907_TEST_ANNOUNCEMENT_07?>','9907','/home/root/MickeyAudioSamples/Time_to_arm_the_perimeter.wav'),('Walk in door is open','<?=$9908_TEST_ANNOUNCEMENT_08?>','9908','/home/root/MickeyAudioSamples/Walk_in_door_is_open.wav');
/*!40000 ALTER TABLE `TestAnnouncements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TestGreetings`
--

DROP TABLE IF EXISTS `TestGreetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TestGreetings` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(80) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TestGreetings`
--

LOCK TABLES `TestGreetings` WRITE;
/*!40000 ALTER TABLE `TestGreetings` DISABLE KEYS */;
INSERT INTO `TestGreetings` VALUES ('Greeter Demo Clip','<?=$9901_TEST_GREETING_01?>','9971','/home/root/MickeyAudioSamples/Greetings/Greeter_Demo_Clip.wav');
/*!40000 ALTER TABLE `TestGreetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TestUpdates`
--

DROP TABLE IF EXISTS `TestUpdates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TestUpdates` (
  `Name` text NOT NULL,
  `MikeyTag` text NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Value` varchar(40) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TestUpdates`
--

LOCK TABLES `TestUpdates` WRITE;
/*!40000 ALTER TABLE `TestUpdates` DISABLE KEYS */;
INSERT INTO `TestUpdates` VALUES ('Store Name','<?=$002_storeName?>','002','TES5'),('Store-ID','<?=$001_storeID?>','001','9900'),('Street Address','<?=$004_streetAddress?>','004','26 Research Avenue'),('City','<?=$005_cityName?>','005','Edinburgh'),('State/Province','<?=$007_stateProvince?>','007','Midlothian'),('Postal Code','<?=$006_postalCode?>','006','EH26'),('Country','<?=$008_countryName?>','008','UK'),('Contact Tel. No.','<?=$003_contactTel?>','003','01234 567891'),('Time Zone','<?=$608_Timezone?>','608','Time Zone'),('Store Name','<?=$002_storeName?>','002','TES5'),('Store-ID','<?=$001_storeID?>','001','9900'),('Street Address','<?=$004_streetAddress?>','004','26 Research Avenue'),('City','<?=$005_cityName?>','005','Edinburgh'),('State/Province','<?=$007_stateProvince?>','007','Midlothian'),('Postal Code','<?=$006_postalCode?>','006','EH26'),('Country','<?=$008_countryName?>','008','UK'),('Contact Tel. No.','<?=$003_contactTel?>','003','01234 567891'),('Time Zone','<?=$608_Timezone?>','608','Time Zone');
/*!40000 ALTER TABLE `TestUpdates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UpdateManagement`
--

DROP TABLE IF EXISTS `UpdateManagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UpdateManagement` (
  `Page` varchar(40) NOT NULL,
  `ID` varchar(40) NOT NULL,
  `Name` text NOT NULL,
  `Value` varchar(40) NOT NULL,
  PRIMARY KEY (`Page`,`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UpdateManagement`
--

LOCK TABLES `UpdateManagement` WRITE;
/*!40000 ALTER TABLE `UpdateManagement` DISABLE KEYS */;
INSERT INTO `UpdateManagement` VALUES ('lca','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('lca','2000','Timestamp','1664180628'),('tme','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('tme','2000','Timestamp','1664180660'),('hol','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('hol','2000','Timestamp','1663927954'),('hsm','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('hsm','2000','Timestamp','1663934368'),('noi','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('noi','2000','Timestamp','1663928049'),('glb','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('glb','2000','Timestamp','1663934366'),('ord','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('ord','2000','Timestamp','1663934375'),('msc','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('msc','2000','Timestamp','1663928341'),('ltm','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('ltm','2000','Timestamp','1664180747'),('none','1001','TimeZone','6'),('none','1002','BaseOpen','OPENED'),('grd','2001','SessionID','a3792c92dfe7a346eb36eb6d9ebce4bc'),('grd','2000','Timestamp','1663761626'),('msgprops','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('msgprops','2000','Timestamp','1664181202'),('msg','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('msg','2000','Timestamp','1664181158'),('vlm','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('vlm','2000','Timestamp','1663922105'),('ngt','2001','SessionID','a3792c92dfe7a346eb36eb6d9ebce4bc'),('ngt','2000','Timestamp','1663671625'),('mvl','2001','SessionID','a3792c92dfe7a346eb36eb6d9ebce4bc'),('mvl','2000','Timestamp','1663670904'),('ins','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('ins','2000','Timestamp','1664181110'),('cf','2001','SessionID','c1308791b476ee39a3076d5dd99375b7'),('cf','2000','Timestamp','1662479395'),('detectors','2001','SessionID','a3792c92dfe7a346eb36eb6d9ebce4bc'),('detectors','2000','Timestamp','1663761767'),('res','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('res','2000','Timestamp','1664181103'),('dio','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('dio','2000','Timestamp','1663928323'),('voip','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('voip','2000','Timestamp','1664136978'),('cloud','2001','SessionID','c623667b9360c0398be9624a517a1e1a'),('cloud','2000','Timestamp','1663922130');
/*!40000 ALTER TABLE `UpdateManagement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `ID` varchar(40) NOT NULL,
  `Name` text NOT NULL,
  `NameSize` int(11) NOT NULL,
  `MikeyTag` text NOT NULL,
  `Value` varchar(40) NOT NULL,
  `Password` varchar(10) NOT NULL,
  `PasswordSize` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES ('700','UserName1',20,'','User1','1234',4),('701','UserName2',20,'','User2','    ',4),('702','UserName3',20,'','User3','    ',4),('703','UserName4',20,'','User4','    ',4),('704','InstallerName1',20,'','Installer1','12345',5),('705','InstallerName2',20,'','Installer2','     ',5),('706','InstallerName3',20,'','Installer3','     ',5),('707','InstallerName4',20,'','Installer4','     ',5),('708','UserName5',20,'','User5','    ',4),('709','UserName6',20,'','User6','    ',4);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VoIPSettings`
--

DROP TABLE IF EXISTS `VoIPSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VoIPSettings` (
  `textID` varchar(40) NOT NULL,
  `dataValue` varchar(80) NOT NULL,
  PRIMARY KEY (`textID`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VoIPSettings`
--

LOCK TABLES `VoIPSettings` WRITE;
/*!40000 ALTER TABLE `VoIPSettings` DISABLE KEYS */;
INSERT INTO `VoIPSettings` VALUES ('Lane1VoIPEnabled','RADIO_YES'),('Lane1VoIPServer','10.8.8.14'),('Lane1VoIPServerPort','5060'),('Lane1VoIPRegistrar','10.8.8.14'),('Lane1VoIPRegistrarPort','5060'),('Lane1VoIPExtension','1002'),('Lane1VoIPPassword','12345'),('Lane1VoIPOutDial','1001'),('Lane1VoIPProxyEnabled','RADIO_YES'),('Lane2VoIPEnabled','RADIO_NO'),('Lane2VoIPServer','8.23.86.230'),('Lane2VoIPServerPort','5060'),('Lane2VoIPRegistrar','8.23.86.230'),('Lane2VoIPRegistrarPort','5060'),('Lane2VoIPExtension','5713'),('Lane2VoIPPassword','Dig@c5717'),('Lane2VoIPOutDial','5814'),('Lane2VoIPProxyEnabled','RADIO_NO'),('Lane1VoIPAuthentication','1002'),('Lane2VoIPAuthentication','5713'),('Lane1RegStatus','OK'),('Lane1CallStatus','DISCONNCTD'),('Lane1StatusExpiration','1664181771'),('Lane2RegStatus','OK'),('Lane2CallStatus','Not Set'),('Lane2StatusExpiration','1661950312'),('Lane1VoIPOutDialOnSensor','RADIO_YES'),('Lane1VoIPAutoAnswer','RADIO_YES'),('Lane2VoIPOutDialOnSensor','RADIO_YES'),('Lane2VoIPAutoAnswer','RADIO_YES'),('Lane1Attenuation','19'),('Lane2Attenuation','19'),('Lane2AsrDeviceID','98F07B21DE71'),('Lane1AsrDeviceID','98F07B6FD089');
/*!40000 ALTER TABLE `VoIPSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Volume`
--

DROP TABLE IF EXISTS `Volume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Volume` (
  `ID` int(11) NOT NULL,
  `ParamNameID` varchar(45) NOT NULL,
  `ParamValueID` varchar(45) NOT NULL,
  `DataEntryType` varchar(45) NOT NULL,
  `Flags` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamNameID_UNIQUE` (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Volume`
--

LOCK TABLES `Volume` WRITE;
/*!40000 ALTER TABLE `Volume` DISABLE KEYS */;
INSERT INTO `Volume` VALUES (1,'MicVol','17','text',1),(2,'TalkVol','15','text',1),(3,'VehicleAlertVol','10','text',1),(4,'GreeterVol','10','text',1),(5,'ExternalVol','10','text',1),(6,'LabelMicPreampGain','8','text',1);
/*!40000 ALTER TABLE `Volume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VolumeParams`
--

DROP TABLE IF EXISTS `VolumeParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VolumeParams` (
  `Name` varchar(45) NOT NULL,
  `ValueName` varchar(45) NOT NULL,
  `Value` varchar(45) NOT NULL,
  `DisplayOrder` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`,`ValueName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VolumeParams`
--

LOCK TABLES `VolumeParams` WRITE;
/*!40000 ALTER TABLE `VolumeParams` DISABLE KEYS */;
INSERT INTO `VolumeParams` VALUES ('MicVol','MIN_INT_VALUE','0',NULL),('MicVol','MAX_INT_VALUE','20',NULL),('TalkVol','MIN_INT_VALUE','0',NULL),('TalkVol','MAX_INT_VALUE','20',NULL),('VehicleAlertVol','MIN_INT_VALUE','0',NULL),('VehicleAlertVol','MAX_INT_VALUE','20',NULL),('GreeterVol','MIN_INT_VALUE','0',NULL),('GreeterVol','MAX_INT_VALUE','20',NULL),('ExternalVol','MIN_INT_VALUE','0',NULL),('ExternalVol','MAX_INT_VALUE','20',NULL),('LabelMicPreampGain','MIN_INT_VALUE','0',NULL),('LabelMicPreampGain','MAX_INT_VALUE','20',NULL);
/*!40000 ALTER TABLE `VolumeParams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkingHours`
--

DROP TABLE IF EXISTS `WorkingHours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingHours` (
  `DayNo` int(11) NOT NULL,
  `DayNameID` varchar(45) NOT NULL,
  `OpenTimeNameID` varchar(45) NOT NULL,
  `OpenTimeValue` text NOT NULL,
  `CloseTimeNameID` varchar(45) NOT NULL,
  `CloseTimeValue` text NOT NULL,
  `DayTimeNameID` varchar(45) NOT NULL,
  `DayTimeValue` text NOT NULL,
  `NightTimeNameID` varchar(45) NOT NULL,
  `NightTimeValue` text NOT NULL,
  PRIMARY KEY (`DayNameID`),
  UNIQUE KEY `DayNameID_UNIQUE` (`DayNameID`),
  UNIQUE KEY `DayNo_UNIQUE` (`DayNo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingHours`
--

LOCK TABLES `WorkingHours` WRITE;
/*!40000 ALTER TABLE `WorkingHours` DISABLE KEYS */;
INSERT INTO `WorkingHours` VALUES (1,'Mon','OpenTime','05:25','CloseTime','01:05','DayTime','08:00','NightTime','19:00'),(2,'Tue','OpenTime','05:25','CloseTime','01:05','DayTime','08:00','NightTime','19:00'),(3,'Wed','OpenTime','05:25','CloseTime','08:00','DayTime','06:00','NightTime','07:00'),(4,'Thu','OpenTime','05:25','CloseTime','01:05','DayTime','08:00','NightTime','19:00'),(5,'Fri','OpenTime','05:25','CloseTime','02:05','DayTime','08:00','NightTime','19:00'),(6,'Sat','OpenTime','05:25','CloseTime','02:05','DayTime','08:00','NightTime','19:00'),(7,'Sun','OpenTime','05:25','CloseTime','01:05','DayTime','10:00','NightTime','17:00');
/*!40000 ALTER TABLE `WorkingHours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_params`
--

DROP TABLE IF EXISTS `sys_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_params` (
  `ID` int(11) NOT NULL,
  `Name` text,
  `Value` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_params`
--

LOCK TABLES `sys_params` WRITE;
/*!40000 ALTER TABLE `sys_params` DISABLE KEYS */;
INSERT INTO `sys_params` VALUES (1,'Store-ID',NULL),(2,'Store Name',NULL),(3,'Contact Tel. No.',NULL),(4,'Street Address',NULL),(5,'City',NULL),(6,'Postal Code',NULL),(7,'State/Province',NULL),(8,'Country',NULL),(9,'Use Custom Tech Service Message',NULL),(10,'Custom Tech Service Message',NULL),(11,'Open Time | Monday',NULL),(12,'Close Time | Monday',NULL),(13,'Day Time | Monday',NULL),(14,'Night Time | Monday',NULL),(15,'Open Time | Tuesday',NULL),(16,'Close Time | Tuesday',NULL),(17,'Day Time | Tuesday',NULL),(18,'Night Time | Tuesday',NULL),(19,'Open Time | Wednesday',NULL),(20,'Close Time | Wednesday',NULL),(21,'Day Time | Wednesday',NULL),(22,'Night Time | Wednesday',NULL),(23,'Open Time | Thursday',NULL),(24,'Close Time | Thursday',NULL),(25,'Day Time | Thursday',NULL),(26,'Night Time | Thursday',NULL),(27,'Open Time | Friday',NULL),(28,'Close Time | Friday',NULL),(29,'Day Time | Friday',NULL),(30,'Night Time | Friday',NULL),(31,'Open Time | Saturday',NULL),(32,'Close Time | Saturday',NULL),(33,'Day Time | Saturday',NULL),(34,'Night Time | Saturday',NULL),(35,'Open Time | Sunday',NULL),(36,'Close Time | Sunday',NULL),(37,'Day Time | Sunday',NULL),(38,'Night Time | Sunday',NULL),(39,'Date | Day 1',NULL),(40,'Open Time | Day 1',NULL),(41,'Close Time | Day 1',NULL),(42,'Date | Day 2',NULL),(43,'Open Time | Day 2',NULL),(44,'Close Time | Day 2',NULL),(45,'Date | Day 3',NULL),(46,'Open Time | Day 3',NULL),(47,'Close Time | Day 3',NULL),(48,'Date | Day 4',NULL),(49,'Open Time | Day 4',NULL),(50,'Close Time | Day 4',NULL),(51,'Date | Day 5',NULL),(52,'Open Time | Day 5',NULL),(53,'Close Time | Day 5',NULL),(54,'Date | Day 6',NULL),(55,'Open Time | Day 6',NULL),(56,'Close Time | Day 6',NULL),(57,'Date | Day 7',NULL),(58,'Open Time | Day 7',NULL),(59,'Close Time | Day 7',NULL),(60,'Date | Day 8',NULL),(61,'Open Time | Day 8',NULL),(62,'Close Time | Day 8',NULL),(63,'Date | Day 9',NULL),(64,'Open Time | Day 9',NULL),(65,'Close Time | Day 9',NULL),(66,'Date | Day 10',NULL),(67,'Open Time | Day 10',NULL),(68,'Close Time | Day 10',NULL),(69,'Date | Day 11',NULL),(70,'Open Time | Day 11',NULL),(71,'Close Time | Day 11',NULL),(72,'Date | Day 12',NULL),(73,'Open Time | Day 12',NULL),(74,'Close Time | Day 12',NULL),(75,'Name | Part 1',NULL),(76,'Start Time | Part 1',NULL),(77,'End Time | Part 1',NULL),(78,'Name | Part 2',NULL),(79,'Start Time | Part 2',NULL),(80,'End Time | Part 2',NULL),(81,'Name | Part 3',NULL),(82,'Start Time | Part 3',NULL),(83,'End Time | Part 3',NULL),(84,'Name | Part 4',NULL),(85,'Start Time | Part 4',NULL),(86,'End Time | Part 4',NULL),(87,'Name | Part 5',NULL),(88,'Start Time | Part 5',NULL),(89,'End Time | Part 5',NULL),(90,'Name | Part 6',NULL),(91,'Start Time | Part 6',NULL),(92,'End Time | Part 6',NULL),(93,'Name | Part 7',NULL),(94,'Start Time | Part 7',NULL),(95,'End Time | Part 7',NULL),(96,'Name | Part 8',NULL),(97,'Start Time | Part 8',NULL),(98,'End Time | Part 8',NULL),(99,'Name | Shift 1',NULL),(100,'Start Time | Shift 1',NULL),(101,'End Time | Shift 1',NULL),(102,'Name | Shift 2',NULL),(103,'Start Time | Shift 2',NULL),(104,'End Time | Shift 2',NULL),(105,'Name | Shift 3',NULL),(106,'Start Time | Shift 3',NULL),(107,'End Time | Shift 3',NULL),(108,'Name | Shift 4',NULL),(109,'Start Time | Shift 4',NULL),(110,'End Time | Shift 4',NULL),(111,'Inbound microphone',NULL),(112,'Outbound talk',NULL),(113,'Vehicle alert',NULL),(114,'Volume | Inbound listen',NULL),(115,'State | Inbound listen',NULL),(116,'Volume | Outbound talk',NULL),(117,'State | Outbound talk',NULL),(118,'Volume | Vehicle present',NULL),(119,'State | Vehicle present',NULL),(120,'Volume | Vehicle approach',NULL),(121,'State | Vehicle approach',NULL),(122,'Volume | Page messages',NULL),(123,'State | Page messages',NULL),(124,'Volume | Greeter messages',NULL),(125,'State | Greeter messages',NULL),(126,'Inbound microphone NR level',NULL),(129,'Self Monitoring Enabled ?',NULL),(130,'Resend Error Reports',NULL),(131,'Number Of Inactive Days Allowed',NULL),(132,'Text and Audio Prompts Language',NULL),(133,'DriveThru Audio Duplex Mode',NULL),(134,'PAGE\' Channel Heard by Order Taker',NULL),(135,'Number of Base Stations at This Site',NULL),(136,'Lane Number of This Base Station',NULL),(137,'Pull Ahead\' Prompt (Tandem Only!)',NULL),(138,'Store Is Now Closed\'  Prompt',NULL),(143,'IP Address 1',NULL),(144,'IP Address 2',NULL),(145,'IP Address 3',NULL),(146,'IP Address 4',NULL),(148,'Subnet Mask 1',NULL),(149,'Subnet Mask 2',NULL),(150,'Subnet Mask 3',NULL),(151,'Subnet Mask 4',NULL),(153,'Default Gateway 1',NULL),(154,'Default Gateway 2',NULL),(155,'Default Gateway 3',NULL),(156,'Default Gateway 4',NULL),(158,'Email Server Address 1',NULL),(159,'Email Server Address 2',NULL),(160,'Email Server Address 3',NULL),(161,'Email Server Address 4',NULL),(169,'Manual Listen /Push To Talk',NULL),(170,'Manual Listen / Manual Latching Talk',NULL),(171,'Auto Listen / Push To Talk',NULL),(172,'Auto Listen / Manual Latching Talk',NULL),(173,'Hands Free',NULL),(174,'Outside',NULL),(175,'Always On',NULL),(176,'Playback After Delay of ( seconds )',NULL),(177,'Playback to The Headsets',NULL),(178,'Playback Through Monitor',NULL),(179,'Tone to The Headsets During Playback',NULL),(180,'Restaurant Closed Message',NULL),(181,'External Detector Message',NULL),(224,'Main Display Counter For',NULL),(226,'Percentage of Current',NULL),(227,'For',NULL),(229,'LED #1',NULL),(230,'LED #2',NULL),(231,'LED #3',NULL),(232,'LED #4',NULL),(233,'LED #5',NULL),(234,'LED #6',NULL),(235,'Lane Mode',NULL),(236,'OrderPoint Prompts in French',NULL),(237,'PlaybackMode',NULL),(243,'Selected Mode',NULL),(245,'OrderPoint Prompts in English',NULL),(246,'OrderPoint Prompts in Spanish',NULL),(247,'Split Lane Talk Can Cross Lanes',NULL),(248,'Page Messages Can Cross Lanes',NULL),(250,'Auto Unmute HS microphone in HandsFree mode',NULL),(252,'Outbound greeter',NULL),(253,'Acoustic Echo Canceller',NULL),(255,'Email Address Suffix',NULL),(257,'Mic preamp',NULL),(258,'Message #1 Duration',NULL),(259,'Message #2 Duration',NULL),(260,'Message #3 Duration',NULL),(261,'Message #4 Duration',NULL),(262,'Name | Detector 1',NULL),(263,'Type | Detector 1',NULL),(265,'MIN | Detector 1',NULL),(266,'MAX | Detector 1',NULL),(267,'Name | Detector 2',NULL),(268,'Type | Detector 2',NULL),(270,'MIN | Detector 2',NULL),(271,'MAX | Detector 2',NULL),(272,'Name | Detector 3',NULL),(273,'Type | Detector 3',NULL),(275,'MIN | Detector 3',NULL),(276,'MAX | Detector 3',NULL),(277,'Name | Detector 4',NULL),(278,'Type | Detector 4',NULL),(280,'MIN | Detector 4',NULL),(281,'MAX | Detector 4',NULL),(282,'Name | Detector 5',NULL),(283,'Type | Detector 5',NULL),(285,'MIN | Detector 5',NULL),(286,'MAX | Detector 5',NULL),(287,'Name | Detector 6',NULL),(288,'Type | Detector 6',NULL),(290,'MIN | Detector 6',NULL),(291,'MAX | Detector 6',NULL),(292,'Greeter goal | Time | Part 1',NULL),(293,'Greeter goal | Time | Monday ',NULL),(294,'Greeter goal | Time | Shift 1',NULL),(295,'Greeter goal | Time | Part 2',NULL),(296,'Greeter goal | Time | Tuesday',NULL),(297,'Greeter goal | Time | Shift 2',NULL),(298,'Greeter goal | Time | Part 3',NULL),(299,'Greeter goal | Time | Wednesday',NULL),(300,'Greeter goal | Time | Shift 3',NULL),(301,'Greeter goal | Time | Part 4',NULL),(302,'Greeter goal | Time | Thursday',NULL),(303,'Greeter goal | Time | Shift 4',NULL),(304,'Greeter goal | Time | Part 5',NULL),(305,'Greeter goal | Time | Friday',NULL),(306,'Greeter goal | Time | Part 6',NULL),(307,'Greeter goal | Time | Saturday',NULL),(308,'Greeter goal | Time | Part 7',NULL),(309,'Greeter goal | Time | Sunday',NULL),(310,'Greeter goal | Time | Part 8',NULL),(311,'Detector #1 goal | Time | Part 1',NULL),(312,'Detector #1 goal | Time | Monday ',NULL),(313,'Detector #1 goal | Time | Shift 1',NULL),(314,'Detector #1 goal | Time | Part 2',NULL),(315,'Detector #1 goal | Time | Tuesday',NULL),(316,'Detector #1 goal | Time | Shift 2',NULL),(317,'Detector #1 goal | Time | Part 3',NULL),(318,'Detector #1 goal | Time | Wednesday',NULL),(319,'Detector #1 goal | Time | Shift 3',NULL),(320,'Detector #1 goal | Time | Part 4',NULL),(321,'Detector #1 goal | Time | Thursday',NULL),(322,'Detector #1 goal | Time | Shift 4',NULL),(323,'Detector #1 goal | Time | Part 5',NULL),(324,'Detector #1 goal | Time | Friday',NULL),(325,'Detector #1 goal | Time | Part 6',NULL),(326,'Detector #1 goal | Time | Saturday',NULL),(327,'Detector #1 goal | Time | Part 7',NULL),(328,'Detector #1 goal | Time | Sunday',NULL),(329,'Detector #1 goal | Time | Part 8',NULL),(330,'Detector #2 goal | Time | Part 1',NULL),(331,'Detector #2 goal | Time | Monday ',NULL),(332,'Detector #2 goal | Time | Shift 1',NULL),(333,'Detector #2 goal | Time | Part 2',NULL),(334,'Detector #2 goal | Time | Tuesday',NULL),(335,'Detector #2 goal | Time | Shift 2',NULL),(336,'Detector #2 goal | Time | Part 3',NULL),(337,'Detector #2 goal | Time | Wednesday',NULL),(338,'Detector #2 goal | Time | Shift 3',NULL),(339,'Detector #2 goal | Time | Part 4',NULL),(340,'Detector #2 goal | Time | Thursday',NULL),(341,'Detector #2 goal | Time | Shift 4',NULL),(342,'Detector #2 goal | Time | Part 5',NULL),(343,'Detector #2 goal | Time | Friday',NULL),(344,'Detector #2 goal | Time | Part 6',NULL),(345,'Detector #2 goal | Time | Saturday',NULL),(346,'Detector #2 goal | Time | Part 7',NULL),(347,'Detector #2 goal | Time | Sunday',NULL),(348,'Detector #2 goal | Time | Part 8',NULL),(349,'Detector #3 goal | Time | Part 1',NULL),(350,'Detector #3 goal | Time | Monday ',NULL),(351,'Detector #3 goal | Time | Shift 1',NULL),(352,'Detector #3 goal | Time | Part 2',NULL),(353,'Detector #3 goal | Time | Tuesday',NULL),(354,'Detector #3 goal | Time | Shift 2',NULL),(355,'Detector #3 goal | Time | Part 3',NULL),(356,'Detector #3 goal | Time | Wednesday',NULL),(357,'Detector #3 goal | Time | Shift 3',NULL),(358,'Detector #3 goal | Time | Part 4',NULL),(359,'Detector #3 goal | Time | Thursday',NULL),(360,'Detector #3 goal | Time | Shift 4',NULL),(361,'Detector #3 goal | Time | Part 5',NULL),(362,'Detector #3 goal | Time | Friday',NULL),(363,'Detector #3 goal | Time | Part 6',NULL),(364,'Detector #3 goal | Time | Saturday',NULL),(365,'Detector #3 goal | Time | Part 7',NULL),(366,'Detector #3 goal | Time | Sunday',NULL),(367,'Detector #3 goal | Time | Part 8',NULL),(368,'Detector #4 goal | Time | Part 1',NULL),(369,'Detector #4 goal | Time | Monday ',NULL),(370,'Detector #4 goal | Time | Shift 1',NULL),(371,'Detector #4 goal | Time | Part 2',NULL),(372,'Detector #4 goal | Time | Tuesday',NULL),(373,'Detector #4 goal | Time | Shift 2',NULL),(374,'Detector #4 goal | Time | Part 3',NULL),(375,'Detector #4 goal | Time | Wednesday',NULL),(376,'Detector #4 goal | Time | Shift 3',NULL),(377,'Detector #4 goal | Time | Part 4',NULL),(378,'Detector #4 goal | Time | Thursday',NULL),(379,'Detector #4 goal | Time | Shift 4',NULL),(380,'Detector #4 goal | Time | Part 5',NULL),(381,'Detector #4 goal | Time | Friday',NULL),(382,'Detector #4 goal | Time | Part 6',NULL),(383,'Detector #4 goal | Time | Saturday',NULL),(384,'Detector #4 goal | Time | Part 7',NULL),(385,'Detector #4 goal | Time | Sunday',NULL),(386,'Detector #4 goal | Time | Part 8',NULL),(387,'Detector #5 goal | Time | Part 1',NULL),(388,'Detector #5 goal | Time | Monday ',NULL),(389,'Detector #5 goal | Time | Shift 1',NULL),(390,'Detector #5 goal | Time | Part 2',NULL),(391,'Detector #5 goal | Time | Tuesday',NULL),(392,'Detector #5 goal | Time | Shift 2',NULL),(393,'Detector #5 goal | Time | Part 3',NULL),(394,'Detector #5 goal | Time | Wednesday',NULL),(395,'Detector #5 goal | Time | Shift 3',NULL),(396,'Detector #5 goal | Time | Part 4',NULL),(397,'Detector #5 goal | Time | Thursday',NULL),(398,'Detector #5 goal | Time | Shift 4',NULL),(399,'Detector #5 goal | Time | Part 5',NULL),(400,'Detector #5 goal | Time | Friday',NULL),(401,'Detector #5 goal | Time | Part 6',NULL),(402,'Detector #5 goal | Time | Saturday',NULL),(403,'Detector #5 goal | Time | Part 7',NULL),(404,'Detector #5 goal | Time | Sunday',NULL),(405,'Detector #5 goal | Time | Part 8',NULL),(406,'Detector #6 goal | Time | Part 1',NULL),(407,'Detector #6 goal | Time | Monday ',NULL),(408,'Detector #6 goal | Time | Shift 1',NULL),(409,'Detector #6 goal | Time | Part 2',NULL),(410,'Detector #6 goal | Time | Tuesday',NULL),(411,'Detector #6 goal | Time | Shift 2',NULL),(412,'Detector #6 goal | Time | Part 3',NULL),(413,'Detector #6 goal | Time | Wednesday',NULL),(414,'Detector #6 goal | Time | Shift 3',NULL),(415,'Detector #6 goal | Time | Part 4',NULL),(416,'Detector #6 goal | Time | Thursday',NULL),(417,'Detector #6 goal | Time | Shift 4',NULL),(418,'Detector #6 goal | Time | Part 5',NULL),(419,'Detector #6 goal | Time | Friday',NULL),(420,'Detector #6 goal | Time | Part 6',NULL),(421,'Detector #6 goal | Time | Saturday',NULL),(422,'Detector #6 goal | Time | Part 7',NULL),(423,'Detector #6 goal | Time | Sunday',NULL),(424,'Detector #6 goal | Time | Part 8',NULL),(425,'Name | Group 1',NULL),(426,'First | Group 1',NULL),(427,'Second | Group 1',NULL),(428,'Third | Group 1',NULL),(429,'Fourth | Group 1',NULL),(430,'Fifth | Group 1',NULL),(431,'Sixth | Group 1',NULL),(432,'Name | Group 2',NULL),(433,'First | Group 2',NULL),(434,'Second | Group 2',NULL),(435,'Third | Group 2',NULL),(436,'Fourth | Group 2',NULL),(437,'Fifth | Group 2',NULL),(438,'Sixth | Group 2',NULL),(439,'Name | Group 3',NULL),(440,'First | Group 3',NULL),(441,'Second | Group 3',NULL),(442,'Third | Group 3',NULL),(443,'Fourth | Group 3',NULL),(444,'Fifth | Group 3',NULL),(445,'Sixth | Group 3',NULL),(446,'Name | Group 4',NULL),(447,'First | Group 4',NULL),(448,'Second | Group 4',NULL),(449,'Third | Group 4',NULL),(450,'Fourth | Group 4',NULL),(451,'Fifth | Group 4',NULL),(452,'Sixth | Group 4',NULL),(453,'Name | Group 5',NULL),(454,'First | Group 5',NULL),(455,'Second | Group 5',NULL),(456,'Third | Group 5',NULL),(457,'Fourth | Group 5',NULL),(458,'Fifth | Group 5',NULL),(459,'Sixth | Group 5',NULL),(460,'Name | Group 6',NULL),(461,'First | Group 6',NULL),(462,'Second | Group 6',NULL),(463,'Third | Group 6',NULL),(464,'Fourth | Group 6',NULL),(465,'Fifth | Group 6',NULL),(466,'Sixth | Group 6',NULL),(570,'Web Server Enabled',NULL),(573,'Email Enabled',NULL),(581,'Message #1 Enabled',NULL),(584,'Message #2 Enabled',NULL),(587,'Message #3 Enabled',NULL),(590,'Message #4 Enabled',NULL);
/*!40000 ALTER TABLE `sys_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `ParamNameID` varchar(20) NOT NULL,
  `ParamValue` varchar(45) NOT NULL,
  PRIMARY KEY (`ParamNameID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` VALUES ('AudioBaseDir','/usr/venus/audio'),('AudioUserDir','user'),('AudioBuiltInDir','standard');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-26  8:38:08
