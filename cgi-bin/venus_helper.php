<?php
/******************************************************************************
**
**  COMPONENT:          venus_helper - support functions for Venus
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
**  Provides a common functionality providing support for the venus platform
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/


/******************************************************************************/
/*    Macro Definitions                                                       */
/******************************************************************************/
define( "HOST_NAME", "localhost" );
define( "DATABASE_NAME", "ares" );
define( "USER_NAME", "root" );
define( "PASSWORD", "" );
define( "TIMESTAMP_ID", "2000" );
define( "SESSION_ID", "2001" );
define( "GUARANTEED_PERIOD", "10" );
define( "UPDATE_MGT_TABLE", "UpdateManagement" );

define( "SESS_LOGIN_IP", "loginIP" );
define( "SESS_USERNAME", "username" );
define( "SESS_LANGUAGE", "language" );
define( "SESS_MESSAGE",  "message" );
define( "SESS_ERROR",    "error" );

define( "SESS_PREV_DATA","PreviousData" );
define( "SESS_PREV_DATA_TS","timestamp" );
define( "SESS_PREV_DATA_SID","sessionID" );

define( "SESS_UPGRADE_START_TIME", "sessionUpgradeStartTime" );
define( "SESS_UPGRADE_REFRESH_COUNT", "sessionUpgradeRefreshCount" );

define( "DEFAULT_LANGUAGE", "en_us" );
define( "TEMPLATE_FOLDER", "templates" );

define( "AJAX_TIMESTAMP", "timestamp" );
define( "AJAX_SESSION_ID", "sessionID" );
define( "AJAX_ERROR", "error" );
define( "AJAX_DATA", "JSONParams" ); // Used in the AJAX send
define( "AJAX_DATA_ERROR", "dataerror" );

define( "EXT_TRIG_ORIGINAL_MODE", "255" );

// HTML form control used for data entry
define( "DATA_ENTRY_SELECT", "select" );
define( "DATA_ENTRY_RADIO", "radio" );
define( "DATA_ENTRY_YESNO_RADIO", "yesnoradio" );
define( "DATA_ENTRY_YESNO_RADIO_DISABLED", "yesnoradiodisabled" );
define( "DATA_ENTRY_TEXT", "text" );
define( "DATA_ENTRY_DISABLED_TEXT", "textdisabled" );
define( "DATA_ENTRY_DISPLAY_ONLY", "displayonly" );
define( "DATA_ENTRY_HIDDEN", "hidden" );

define( "DATA_ENTRY_YES", "RADIO_YES" );
define( "DATA_ENTRY_NO", "RADIO_NO" );

// Data validataion database flags
define( "DATA_ENTRY_MINMAX", 1 );
define( "DATA_ENTRY_LENGTH", 2 );

// Data validation parameter names
define( "DATA_ENTRY_MIN_INT_VALUE", "MIN_INT_VALUE" );
define( "DATA_ENTRY_MAX_INT_VALUE", "MAX_INT_VALUE" );
define( "DATA_ENTRY_MAX_LENGTH",    "MAX_LENGTH" );

// Update table entries used for miscelany
define( "UPDATEMGT_TZ", "TimeZone" );
define( "UPDATEMGT_BaseOpen", "BaseOpen" );

// Upgrade tarball upload
define( "UPGRADE_TB_KEY", "TBUpgradeFile" );
define( "UPGRADE_TB_FILENAME", "TBUpgrade.gz" );
define( "UPGRADE_TB_UPLOAD_STAGEDIR", "/tmp" );
define( "UPGRADE_TB_RESERVED_SPACE", 1048576 ); /* Ensure 1MB is reserved in volatile memory */
define( "UPGRADE_TB_UPLOAD_EXTRACT_DIR_ROOT", "/home/root" );
define( "UPGRADE_TB_UPLOAD_EXTRACT_FLASH_DIR_ROOT", "/mnt/flash" );
define( "UPGRADE_TB_UPLOAD_EXTRACT_DIR_NAME", "upgrade" );
define( "REDIRECT_OUTPUT_TO_NULL", " > /dev/null 2>&1" );
define( "UPGRADE_SCRIPT","/usr/venus/scripts/upgrade.sh" );
define( "PROGRESS_CHECK_SCRIPT","/usr/bin/do_check_upgrade_progress.sh" );
define( "PROGRESS_REFRESH_PERIOD", 5 ); /* In seconds */
define( "PROGRESS_UNZIP_TIMEOUT", 60 ); /* In seconds */

// Configuration database upload/download
define( "CONFIG_LOCAL_PATH_FILENAME", "/home/root/user_backup.sql" );

define( "CONFIG_REMOTE_FILENAME", "configDB.gz" );
define( "CONFIG_LOCAL_ROOT", "/home/root" );
define( "UPLOAD_DB_KEY", "DBUploadFile" );
define( "UPLOAD_DB_FILENAME", "user_backup.sql" );
define( "UPLOAD_DB_TMP_BACKUP", "user_backup_tmp.sql" );
define( "UPLOAD_DB_UPLOAD_STAGEDIR", "/tmp" );
define( "UPLOAD_DB_REQUIRED_SPACE", 1296040 ); 
define( "ACCESS_DB_ALLOWED_SCRIPT", "/usr/bin/is_restoring_or_backing_up_web.sh");

// Factory restore, and Remote Saving and loading of installer settings
define( "INS_DB_SAVE_SCRIPT", "/usr/bin/do_user_backup_web.sh");
define( "INS_DB_LOAD_SCRIPT", "/usr/bin/do_user_restore_web.sh");
define( "INS_FACTORY_SCRIPT", "/usr/bin/venus_factory.sh");

// Date and time update
define( "LTM_DATE_TIME_SCRIPT", "/usr/bin/venus_change_date_time.sh" );

// Remote reboot from reboot page
define( "RES_REBOOT_SCRIPT", "/usr/bin/venus_reboot.sh");

// Message properties page
define( "MIN_REPEAT_COUNT", 1 );
define( "MAX_REPEAT_COUNT", 255 );
define( "NO_OF_HEADSETS", 20 );
define( "NO_OF_DAYS", 7 );
define( "NO_OF_DAYPARTS", 12 );

// Diagnostic/Status page
define( "DIAGNOSTICS_CHECK_SCRIPT", "/usr/bin/venus_list_errors.sh" );
define( "MAX_DIAG_ENTRIES", 10 );
define( "STATUS_CHECK_APP", "/usr/bin/send_get_lane_status_message" );
define( "MMI_STATUS_VEHICLE", 0x01 );
define( "MMI_STATUS_LISTEN",  0x02 );
define( "MMI_STATUS_TALK",    0x04 );
define( "MMI_STATUS_PAGE",    0x08 );
define( "UPTIME_CMD", "last reboot  -R -1" );

// Digital input/output configuration pages
define( "DIO_DIR_INPUT",  0 );
define( "DIO_DIR_OUTPUT", 1 );

// Current time/date and mode page (LTM)
define( "NO_OF_TIME_ZONES", 34 );
define( "IGNORE_SELECTION", "IGNORE_SELECTION" );

/******************************************************************************
** Function:    VenusShowError
** Parameters:      connection [in] database handle
** Returns:         Nothing
**
** Stops the script interpreter at this point and gives an error message
** visible on the web-browser.
**
*/
function VenusShowError( $connection )
{
    $errNo = mysqli_errno( $connection );
    $errMsg = mysqli_error( $connection );

    if ( isset( $connection ) )
    {
        // Good idea to unlock any tables if we're going to abort a script
        // Won't do any harm to try even if there are no locked tables
        @mysqli_query( $connection, "UNLOCK TABLES;" );
    }

    // Give details of the error
    die( "Error #: ". $errNo . ": " . $errMsg );
}

/******************************************************************************
** Function:    VenusDBConnect
** Parameters:      None
** Returns:         database handle
**
** Opens a connection handle to local MySQL database
**
*/
function VenusDBConnect()
{
    if ( !($connection =
         mysqli_connect( HOST_NAME, USER_NAME, PASSWORD, DATABASE_NAME)))
    {
        VenusShowError($connection);
    }
    return ( $connection );
}

/******************************************************************************
** Function:    VenusDBClose
** Parameters:      connection [in/out] database handle
** Returns:         Nothing
**
** Closes the connection to the database, and invalidates the handle.
**
*/
function VenusDBClose( &$connection )
{
    mysqli_close( $connection );
    unset( $connection );
}

/******************************************************************************
** Function:    VenusDBValFmID
** Parameters:      connection [in] database handle
**                  table [in] database table name
**                  ID [in] ID of parameter to extract
**                  returnOnly [in] output control flag
** Returns:         parameter value for row containing ID
**
** Gets the parameter value associated with the ID from the given table
**
*/
function VenusDBValFmID( $connection, $table, $ID, $returnOnly=false )
    {
        $ID = VenusMySqlVarClean( $ID, 10, $connection );
        if ( !( $result = @mysqli_query( $connection, "SELECT * FROM $table where ID='$ID'" ) ))
        {
            VenusShowError($connection);
        }
        else
        {
            mysqli_free_result( $result );
        }
        $row = @mysqli_fetch_array( $result, MYSQLI_ASSOC );

        $rowResult = "{$row['Value']}";
        if ( !$returnOnly )
        {
          echo $rowResult;
        }

      return $rowResult;
    }

function stripslashes_deep($value)
{
    $value = is_array($value) ?
                array_map('stripslashes_deep', $value) :
                stripslashes($value);

    return $value;
}

/******************************************************************************
** Function:    VenusMySqlClean
** Parameters:      array [in] array containing element to be cleaned
**                  index [in] element to be cleaned
**                  maxlength [in] truncation point
**                  connection [in] database handle
** Returns:         'cleaned' variable
**
** Protects an array element used in an SQL query from being used for SQL
** injection. Truncates variable value and escapes out any potentially
** damaging characters.
**
*/
function VenusMySqlClean( $array, $index, $maxlength, $connection )
{
    if ( isset( $array[ "{$index}" ] ))
    {
        return (
            VenusMySqlVarClean( $array[ "{$index}" ],
                $maxlength,
                $connection ) );
    }
    return null;
}

/******************************************************************************
** Function:    VenusMySqlVarClean
** Parameters:      var [in] variable to be cleaned
**                  maxlength [in] truncation point
**                  connection [in] database handle
** Returns:         'cleaned' variable
**
** Protects a variable used in an SQL query from being used for SQL
** injection. Truncates variable value and escapes out any potentially
** damaging characters.
**
*/
function VenusMySqlVarClean( $var, $maxlength, $connection )
{
    $input = null;
    $input = substr( $var, 0, $maxlength );
    $input = mysqli_real_escape_string( $connection, $input );
    return ( $input );
}

/******************************************************************************
** Function:    VenusAuthenticateUser
** Parameters:      connection [in] database handle
**                  username [in]
**                  password [in]
** Returns:         true if authenticated, false otherwise
**
** Looks up the username and password information in the users table.
** Password is store clear of encryption in database. Security must
** be achieved by ensuring password is sent from browser under SSL.
**
*/
function VenusAuthenticateUser( $connection, $username, $password )
{
    $table = "Users";

    $username = VenusMySqlVarClean( $username, 20, $connection );
    $password = VenusMySqlVarClean( $password, 20, $connection );

    if ( !isset( $username ) || !isset( $password ) )
    {
        return false;
    }
    $query = "SELECT Password FROM {$table} where Value = '{$username}'
              AND Password = '{$password}';";

    if ( !$result = @mysqli_query( $connection, $query ) )
    {
        return false;
    }

    $success = false;

    if ( @mysqli_num_rows( $result ) == 1 )
    {
        $success = true;
    }

    mysqli_free_result( $result );

    return $success;
}

/******************************************************************************
** Function:    VenusSessionAuthenticate
** Parameters:      redirect [in] true to redirect if authentication fails
** Returns:         true if PHP session is valid
**
** NB: makes use of $_SESSION and $_SERVER PHP global variables.
**
** Checks that the session is valid. It would be invalid if there is no
** username stored in the session (redirect to log-in page) or the ip address
** where the session started is now different (redirect to logout).
**
** The function default behavior is to redirect on invalid session. Set
** redirect flag to false if not required.
**
*/
function VenusSessionAuthenticate( $doRedirect = true )
{
    $redirect = "";
    if ( !isset( $_SESSION[ SESS_USERNAME ] ) )
    {
        $_SESSION[ "message" ] = "Authorisation failed to {$_SERVER["REQUEST_URI"]}";
        $redirect = "Location: login.php";
    }

    // Check for session hijack
    if ( !isset( $_SESSION[ SESS_LOGIN_IP ] )
          || ($_SESSION[SESS_LOGIN_IP ] != $_SERVER["REMOTE_ADDR"] ))
    {
        $_SESSION[ "message" ] = "Authorisation failed to {$_SERVER["REQUEST_URI"]} from ".
                                  "{$_SERVER["REMOTE_ADDR"]}";
        $redirect = "Location: logout.php";
    }

    // Optionally perform redirection
    if ( isset( $redirect ) && ( $redirect != "" ) )
    {
        if ( $doRedirect )
        {
            header(
                $redirect,   // redirect instruction
                true, // overwrite any existing "location" header
                303   // HTTP redirect response: "303 see other"
                 );
        }
        return false; // Not authenticated
    }
    else
    {
        return true;  // Authenticated
    }
}

/******************************************************************************
** Function:    VenusInstallerAccess
** Parameters:      none
** Returns:         true if current user has Installer-level access
**
** NB: makes use of $_SESSION PHP global variables.
**
** Checks whether the current user has Installer-level access rights.
**
*/
function VenusInstallerAccess(  )
{
    if ( !isset( $_SESSION[ SESS_USERNAME ] ) )
    {
        return false; // No value set - can't be an Installer
		/* Note that this is actually an error, but we can't do anything about that here */
    }
	
	$installer = False;

	/* Check for an Installer username */
	if ( $_SESSION[ SESS_USERNAME ] == "Installer1" )
	{
		$installer = True;
	}
	if ( $_SESSION[ SESS_USERNAME ] == "Installer2" )
	{
		$installer = True;
	}
	if ( $_SESSION[ SESS_USERNAME ] == "Installer3" )
	{
		$installer = True;
	}
	if ( $_SESSION[ SESS_USERNAME ] == "Installer4" )
	{
		$installer = True;
	}

	return $installer;
}

/******************************************************************************
** Function:    VenusIsUpdatableCheck
** Parameters:      connection [in] database handle
**                  page [in] the page being updated
**                  timeNow [in] time incoming request arrived
**                  sessonID [in] the PHP session ID for the request
** Returns:         true if an update is allowed, false otherwise
**
** NB: the first visit by a browser to a protected page is stored in the
** table associated with the page. Time and session ID are recorded.
**
** This function checks to see whether the update attempt is being made
** by the same visitor within a guaranteed exclusivity period or any
** visitor after the period has ended.
**
*/
function VenusIsUpdatableCheck( $connection, $page, $timeNow, $sessionID )
{
    $updatable = False;

    if ( !$queryResult = @mysqli_query( $connection,
        "SELECT ID, Value from ".UPDATE_MGT_TABLE." where Page='$page';" ) )
    {
        VenusShowError( $connection );
    }

    while ( $result = @mysqli_fetch_array( $queryResult, MYSQLI_ASSOC ) )
    {
        if ( $result[ "ID" ] == TIMESTAMP_ID )
        {
            $pageServedAt = intval( $result["Value"] );
        }
        else if ( $result[ "ID" ] == SESSION_ID )
        {
            $pageServedTo = $result["Value"];
        }
    }

    if ( isset( $pageServedAt ) && isset( $pageServedTo ) )
    {
        if (
               ($pageServedAt == 0)  // overcome first ever run, seed database
            || ($timeNow < $pageServedAt )  // overcome time sync problems
            || ($timeNow - $pageServedAt ) > intval(GUARANTEED_PERIOD) // normal run
            || (
                ($timeNow - $pageServedAt ) <= intval(GUARANTEED_PERIOD)
                 && $sessionID === $pageServedTo
                )// normal run, same user refreshing
            )
        {
            if ( !@mysqli_query( $connection, "UPDATE ".UPDATE_MGT_TABLE." SET Value='{$timeNow}'
                                WHERE Page='{$page}' AND ID=". TIMESTAMP_ID .";" ) )
             {
                 VenusShowError( $connection );
             }
             else
             {
                  if ( !@mysqli_query( $connection, "UPDATE ".UPDATE_MGT_TABLE." SET Value='{$sessionID}'
                                WHERE Page='{$page}' AND ID=". SESSION_ID .";" ) )
                  {
                    VenusShowError($connection);
                  }
                  else
                  {
                     $updatable = True;
                  }
             }
        }
    }
    mysqli_free_result( $queryResult );

    return $updatable;
}

/******************************************************************************
** Function:    VenusExtractTimestampSession
** Parameters:      parameterArray [in] expanded, decoded JSON data from AJAX send
**                  timestamp [in/out] timestamp of initial form data
**                  sessionID [in/out] session ID of initial form data
** Returns:         Nothing
**
** Extracts the sessionID and the timestamp from other parameter data sent as
** part of an AJAX initiated update.
**
** NB: the time and sessionID are set when the page was first requested and
**     is not updated following any AJAX micro-updates that may occur.
**
*/
function VenusExtractTimestampSession( $parameterArray, &$timestamp, &$sessionID )
{
    $timestamp = "";
    $sessionID = "";

    foreach ( $parameterArray as $object )
    {
        if ( $object->name == AJAX_TIMESTAMP )
        {
            $timestamp = $object->value;
        }
        else if ( $object->name == AJAX_SESSION_ID )
        {
            $sessionID = $object->value;
        }

        if  ( ( $timestamp != "" ) && ( $sessionID != "" ) )
        {
            break;
        }
    }
}


/******************************************************************************
** Function:    VenusPerformFormMultiTableUpdate
** Parameters:      postedData [in] the incoming data received from an HTTP POST
**                  writeTables[in] array of table names locked for writing
**                  readTables [in] array of table names locked for reading
**                  updateFunc [in] the function called to perform the update
**                  warning [in/out] string of error messages destined for rendering
** Returns:         true if update was made, false otherwise
**
** A general purpose function that calls a given update routine to perform
** an update of a table with data originating from a HTTP POST.
**
** Update routine prototype:
**
**    function myUpdateFunc( $connection, $writeTables, readTables,
*                                       $requestData, $processedData, $errors )
**
** Where,
**        connection [in] is the database handle
**        writeTables [in] any tables to be written to (all locked)
**        readTables [in] any tables to be read (all locked)
**        page [in] is the page being updated
**        requestData [in] is the posted data from the browser
**        errors [out] is a string array of errors and warnings
**
** NB: any errors generated are placed into a warning string, and the update function
**     returns false
*/
function VenusPerformFormMultiTableUpdate( $postedData, $writeTables, $readTables, $page, $updateFunc, &$warning )
{
    $success = false;

    $connection = VenusDBConnect();

    $lockingSQLCMD = VenusGenerateSQLLockingCommand( $writeTables, $readTables );
    if ( !@mysqli_query( $connection, $lockingSQLCMD ) )
    {
        VenusShowError( $connection );
    }

    if ( !$queryResult = @mysqli_query( $connection,
        "SELECT ID, Value from ".UPDATE_MGT_TABLE." where Page='$page';" ) )
    {
        VenusShowError( $connection );
    }

    while ( $result = @mysqli_fetch_array( $queryResult, MYSQLI_ASSOC ) )
    {
        if ( $result[ "ID" ] == TIMESTAMP_ID )
        {
            $time_guarantee_start = intval( $result["Value"] );
        }
        else if ( $result[ "ID" ] == SESSION_ID )
        {
            $owning_session = $result["Value"];
        }
    }

    $time_form_requested = intval( $postedData[ "timestamp" ] );

    if ( !isset( $time_guarantee_start ) || !isset( $owning_session ) )
    {
        $warning = "Unable to retrieve session environment. Your changes could not be applied.";
    }
    else
    {
        // Check that no other web-user has gained exclusivity in the meantime
        if ( $time_form_requested === $time_guarantee_start )
        {
            // Double-check the sessions match
            if ( $owning_session === session_id() )
            {
                // Sessions match and no one has, so OK to update
                $success = $updateFunc( $connection, $writeTables, $readTables, $postedData, $errors );
                if ( !$success )
                {
                    if (is_array( $errors ) )
                    {
                        $warning = implode( ", ", $errors );
                    }
                    else
                    {
                        $warning = $errors;
                    }
                }
            }
            else
            {
                $warning = "Active session mismatch. Your changes could not be applied.";
            }
        }
        else
        {
            $warning = "Original data has been updated by another user. Your changes could not be applied.";
        }
    }

    mysqli_free_result( $queryResult );

    if ( ! @mysqli_query( $connection, "UNLOCK TABLES;" ) )
    {
        VenusShowError( $connection );
    }

    return $success;
}

/******************************************************************************
** Function:    VenusPerformAJAXMultiTableUpdate
** Parameters:      JSONRequest [in] the incoming data received from an AJAX send
**                  writeTables[in] array of table names locked for writing
**                  readTables [in] array of table names locked for reading
**                  updateFunc [in] the function called to perform the update
**                  JSONResponse [in/out] the JSON formatted date to be sent
** Returns:         Nothing
**
** A general purpose function that calls a given update routine to perform
** an update of a table with data originating from JSON data. The update
** routine is expected to generate data which will be then encoded to JSON
** to be sent in the response.
**
** Update routine prototype:
**
**    function myUpdateFunc( $connection, $writeTables, readTables,
*                                               $requestData, &$response )
**
** Where,
**        connection [in] is the database handle
**        writeTables [in] any tables to be written to (all locked)
**        readTables [in] any tables to be read (all locked)
**        page [in] the page to be updated
**        requestData [in] is a PHP object array of Name, Value pairs
**        response [in/out] is a PHP object array of Name, Value pairs
**
** NB: any errors generated are formatted into a JSON response.
*/
function VenusPerformAJAXMultiTableUpdate( $JSONRequest, $writeTables, $readTables,
                $page, $updateFunc, &$JSONResponse )
{
    if ( session_start() == false )
    {
        exit;
    }

    if ( VenusSessionAuthenticate() == false )
    {
        exit;
    }

    if ( isset( $JSONRequest ) )
    {
        $connection = VenusDBConnect();

        $response = array();

        $requestData = json_decode( stripslashes( $JSONRequest ) );

        if ( $requestData != null && is_array($requestData) )
        {
            # Extract timestamp and session ID from deserialised array.
            VenusExtractTimestampSession( $requestData, $incomingTimestamp, $incomingSessionID );

            $lockingSQLCMD = VenusGenerateSQLLockingCommand( $writeTables, $readTables );
            if ( !@mysqli_query( $connection, $lockingSQLCMD ) )
            {
                VenusShowError( $connection );
            }

            if ( !$queryResult = @mysqli_query( $connection,
                "SELECT ID, Value from ".UPDATE_MGT_TABLE." where Page='$page';" ) )
            {
                VenusShowError( $connection );
            }

            while ( $result = @mysqli_fetch_array( $queryResult, MYSQLI_ASSOC ) )
            {
                if ( $result[ "ID" ] == TIMESTAMP_ID )
                {
                    $time_guarantee_start = intval( $result["Value"] );
                }
                else if ( $result[ "ID" ] == SESSION_ID )
                {
                    $owning_session = $result["Value"];
                }
            }

            $time_form_requested = intval( $incomingTimestamp );

            if ( !isset( $time_guarantee_start ) || !isset( $owning_session ) )
            {
                $errorValue = "Unable to retrieve session environment. Your changes could not be applied.";
            }
            else
            {
                // Check that no other web-user has gained exclusivity in the meantime
                if ( $time_form_requested == $time_guarantee_start )
                {
                    // Double-check the sessions match
                    if ( $owning_session == $incomingSessionID )
                    {
                        // No one has and the sessions match, so OK to update
                        $updateFunc( $connection, $writeTables, $readTables, $requestData,
                                                                    $response, $dataErrorMessage );
                    }
                    else
                    {
                        $errorValue = "Active session mismatch. Your changes could not be applied.";
                    }
                }
                else
                {
                    $errorValue = "Original data has been updated by another user. Your changes could not be applied.";
                }
            }

            mysqli_free_result( $queryResult );

            if ( ! @mysqli_query( $connection, "UNLOCK TABLES;" ) )
            {
                VenusShowError( $connection );
            }
        }
        else
        {
            // Authenticated user, but trying to directly access a form processor
            $errorValue = "You are not allowed to access this resource directly.";
        }

        if ( isset( $dataErrorMessage ) )
        {
            $response[] = (object) array( "ID"=>AJAX_DATA_ERROR, "Value" => $dataErrorMessage );
        }
        if ( isset( $errorValue ) )
        {
            $response[] = (object) array( "ID"=>AJAX_ERROR, "Value" => $errorValue );
        }

        $JSONResponse = json_encode($response);
        if ( $JSONResponse == false )
        {
            $response = array();  // Clear out current response
            $errorValue = "Unable to form a valid data response.";
            $response[] = (object) array( "ID"=>AJAX_ERROR, "Value" => $errorValue );
            $JSONResponse = json_encode($response);
        }
    }
}

/******************************************************************************
** Function:    VenusGetTemplateName
** Parameters:      page [in] the template page name
** Returns:         filename of template excluding path
**
** NB: uses globals from $_SESSION and $_SERVER
**
** returns the template to use for the page with reference to the selected
** language. If the template for the language is not found the fall back
** is to assume there is a page.en_us.tpl template.
**
*/
function VenusGetTemplateName( $page )
{
    $templateFilename = $page . ".en_us.tpl"; // Assume default template for page

    if ( isset( $_SESSION[ SESS_LANGUAGE ] ) && isset( $_SERVER["SCRIPT_FILENAME"] ) )
    {
        $internationalTemplate = $page.".".$_SESSION[ SESS_LANGUAGE ].".tpl";
        $templatePath =
            dirname( $_SERVER["SCRIPT_FILENAME"] )."/". TEMPLATE_FOLDER;
        if ( file_exists( $templatePath . "/". $internationalTemplate ) )
        {
            $templateFilename = $internationalTemplate;
        }
    }
    return $templateFilename;
}

/******************************************************************************
** Function:    VenusGetLabels
** Parameters:      connection [in] is the database handle
**                  table [in] is the language table to be read
**                  language [in] the language code
**                  key [in] is the label to retrieve
** Returns:         labels in requested language, in en_us, or
**                  an empty array on error.
**
** Used to retrieve labels in the requested language.
** If the requested  language is not available the en_us equivallent
** is returned, otherwise an empty array.
**
** NB: assumes table is locked if other tables have been locked in
** the same context.
*/
function VenusGetLabels( $connection, $table, $language )
{
    $languages = array_unique( array( $language, DEFAULT_LANGUAGE ) );

    $labelArray = array();

    foreach( $languages as $target )
    {
        if ( $result = @mysqli_query( $connection, "SELECT textID, text from {$table} where language='{$target}';" ) )
        {
            while ( ($row = mysqli_fetch_array( $result, MYSQLI_ASSOC )) != NULL )
            {
                if (!isset( $labelArray[ $row[ "textID" ] ] ) )
                {
                    $labelArray[ $row[ "textID" ] ] = $row[ "text" ];
                }
            }
            mysqli_free_result( $result );
        }
        if ( count( $labelArray ) > 0 )
        {
            //break;
        }
    }

    return $labelArray;
}

/******************************************************************************
** Function:    VenusValidateTime
** Parameters:      timeValue [in] candidate time in string format
**                  validTimeStamp [out] UNIX time stamp for candidate
**                  errors [in/out] error information as an array of strings
** Returns:         true if time was correct, false otherwise
**
** Looks for a time in format hours:minute and determines the UNIX
** epoch timestamp. Any errors are issued out of the error parameter.
**
*/
function VenusValidateTime( $timeValue, &$validTimeStamp, &$errors, $allow2400 = false )
{
    $success = false;

    if ($dateTime = date_create_from_format( "H:i", $timeValue ) )
    {
        $timeStamp = date_timestamp_get( $dateTime );
        $validatedTime = date( "H:i", $timeStamp );
        if ( strcmp( $timeValue, $validatedTime ) == 0 )
        {
            $validTimeStamp = $timeStamp;
            $success = true;
        }
        else 
        {
            /* Special case - the entered time is 24:00 */
            $hour = 0; $min = 0;
            $converted = sscanf( $timeValue, "%02d:%02d", $hour, $min );
            if ( ($allow2400 == true ) && ( $converted == 2 ) && ( $hour == 24 ) && ( $min == 0 ) )
            {                                                  
                $validTimeStamp = $timeStamp;                  
                $success = true;                               
            }                                                  
            else                                               
            {                                                  
                $errors[] = "Time value not recognised as a valid time, ";
            }                                                             
        }
    }
    else
    {
        $dgle_errors = date_get_last_errors();
        $errors[] = implode( "; ", $dgle_errors[errors] );
    }

    return $success;
}

/******************************************************************************
** Function:    VenusValidateFullTime
** Parameters:      timeValue [in] candidate time in string format
**                  errors [in/out] error information as an array of strings
** Returns:         true if time was correct, false otherwise
**
** Looks for a time in format hours:minute and determines the UNIX
** epoch timestamp. Any errors are issued out of the error parameter.
**
*/
function VenusValidateFullTime( $timeValue, &$errors )
{
    $success = false;

    if ($dateTime = date_create_from_format( "H:i:s", $timeValue ) )
    {
        $timeStamp = date_timestamp_get( $dateTime );
        $validatedTime = date( "H:i:s", $timeStamp );
        if ( strcmp( $timeValue, $validatedTime ) == 0 )
        {
            $success = true;
        }
        else
        {
            $errors[] = "Time value not recognised as a valid time.";
        }
    }
    else
    {
        $dgle_errors = date_get_last_errors();
        $errors[] = implode( "; ", $dgle_errors[errors] );
    }

    return $success;
}


/******************************************************************************
** Function:    VenusValidateDate
** Parameters:      dateValue [in] candidate date in string format
**                  errors [in/out] error information as an array of strings
**                  allowZeroZero [in] if true allows date 0-0
** Returns:         true if date was correct, false otherwise
**
** Looks for a date in format day-month and validates this a genuine
** day and month of the year.
**
** Any errors are issued out of the error parameter.
**
*/
function VenusValidateDate( $dateValue, &$errors, $allowZeroZero = false )
{
    $success = false;

    if ($dateTime = date_create_from_format( "d-m", $dateValue ) )
    {
        $timeStamp = date_timestamp_get( $dateTime );
        $validatedDate = date( "j-n", $timeStamp );
        if ( strcmp( $dateValue, $validatedDate ) == 0 )
        {
            $success = true;
        }
        else
        {
            // Deal with special cases - zero date and 29 Feb
            $day = 0; $month = 0;
            $converted = sscanf( $dateValue, "%d-%d", $day, $month );
            if ( $converted == 2 )
            {
                if ( 
                       ( ( $allowZeroZero == true ) && ( $day == 0 ) && ( $month == 0 ) )
                    || ( ( $day == 29 ) && ( $month == 2 ) )  )
                {   
                    $success = true;
                }
            }
            else
            {
                $errors[] = "Date value not recognised as a valid date ";
            }
        }
    }
    else
    {
        $dgle_errors = date_get_last_errors();
        $errors[] = implode( "; ", $dgle_errors[errors] );
    }

    return $success;
}

/******************************************************************************
** Function:    VenusValidateFullDate
** Parameters:      dateValue [in] candidate date in string format
**                  errors [in/out] error information as an array of strings
** Returns:         true if date was correct, false otherwise
**
** Looks for a date in format year/month/day and validates this a genuine
** day and month of the given year.
**
** Any errors are issued out of the error parameter.
**
*/
function VenusValidateFullDate( $dateValue, &$errors )
{
    $success = false;

    if ($dateTime = date_create_from_format( "Y/m/d", $dateValue ) )
    {
        $timeStamp = date_timestamp_get( $dateTime );
        $validatedDate = date( "Y/m/d", $timeStamp );
        if ( strcmp( $dateValue, $validatedDate ) == 0 )
        {
            $success = true;
        }
        else
        {
            $errors[] = "Date value not recognised as a valid date.";
        }
    }
    else
    {
        $dgle_errors = date_get_last_errors();
        $errors[] = implode( "; ", $dgle_errors[errors] );
    }

    return $success;
}

/******************************************************************************
** Function:    VenusGetSessPrevDataName
** Parameters:      page [in] web pages associated with session data
** Returns:         concatination of constant name prefix and the page
**                  name.
**
** NB: Useful when NOT using AJAX (i.e. JavaScript is been disabled)
**
** The PHP SESSION is used to store the date from a form whenever there
** is an error on the form. This  means that the user's change to the
** form is not lost when it is validated by the server.
**
** The $_SESSION associative array element holding the error data for
** a specific page is made up of a prefix SESS_PREV_DATA and the name
** of the page containing the form, e.g SESS_PREV_DATA_tme
*/
function VenusGetSessPrevDataName( $page )
{
    return SESS_PREV_DATA . "_" . $page;
}

/******************************************************************************
** Function:    VenusGenerateSQLLockingCommand
** Parameters:      writeTables[in] array of table names to be locked for writing
**                  readTables [in] array of table names to be locked for reading
** Returns:         SQL command to lock tables.
**
** NB: this method always returns at least a command to write lock the
**     table used to indicate what user and session is updating a particular
**     page
*/
function VenusGenerateSQLLockingCommand( $writeTables, $readTables )
{
    $lockingSQL = array( "LOCK TABLES" );
    if ( isset( $writeTables ) && ( !empty( $writeTables ) ) )
    {
        foreach( $writeTables as $wTable )
        {
            $lockingSQL[] = " {$wTable} WRITE,";
        }
    }

    if ( isset( $readTables ) && ( !empty( $readTables ) ) )
    {
        foreach( $readTables as $rTable )
        {
            $lockingSQL[] = " {$rTable} READ,";
        }
    }
    $lockingSQL[] = " " . UPDATE_MGT_TABLE . " WRITE;";

    return implode( $lockingSQL );
}

/******************************************************************************
** Function:    VenusValidateParam
** Parameters:      connection [in] is the database handle
**                  cleanParamName [in] name of item in table to update
**                  cleanParamValue [in] value to validate
**                  table [in] database table name to receive update
**                  tableParams [in] database table containing item parameters
**                  errors [in/out] error information as an array of strings
** Returns:         true Validated OK
**
** Validates the data to that will be added according information related to
** the parameter obtained from the two database tables. The table parameter
** is the table giving details about the type of data and what validation
** should occur and the tableParams table indicates any bounds or values
** used to validate the parameter.
**
** NB: the parameter name and value are assume cleaned and constrained in
** length and therefore would be suitable for use with and in the database.
*/
function VenusValidateParam( $connection, $cleanParamName, $cleanParamValue, $table, $tableParams, &$errors )
{
    $success = false;

    if ( !($paramNamesQuery = @mysqli_query( $connection,
                "select *
                from {$table} where ParamNameID = '{$cleanParamName}';" ) ) )
    {
        VenusShowError( $connection );
    }
    else
    {
        if ( mysqli_num_rows( $paramNamesQuery ) == 1 )
        {
            // Check whether value being set is OK
            if ( strlen( $cleanParamValue ) == 0 )
            {
                // No new value was set, skip to next parameter
                $success = true;
            }
            else
            {
                $paramNamesQueryResult = mysqli_fetch_array( $paramNamesQuery );
                if ( $paramNamesQueryResult == null )
                {
                    $errors[] = "Unable to fetch content for '{$cleanParamName}'.";
                }
                else
                {
                    if ( ( $paramNamesQueryResult["DataEntryType"] == DATA_ENTRY_DISABLED_TEXT )
                         || ( $paramNamesQueryResult["DataEntryType"] == DATA_ENTRY_DISPLAY_ONLY ) )
                    {
                        $success = true;
                    }
                    else
                    {
                        if ( $paramNamesQueryResult["DataEntryType"] == DATA_ENTRY_TEXT )
                        {
                            if ( $paramNamesQueryResult["Flags"] & DATA_ENTRY_MINMAX )
                            {
                                if ( !($paramValidationQuery = @mysqli_query( $connection,
                                        "select *
                                        from {$tableParams}
                                        where Name = '{$cleanParamName}'
                                            and (
                                                ValueName = '".DATA_ENTRY_MIN_INT_VALUE."'
                                                or ValueName = '".DATA_ENTRY_MAX_INT_VALUE."' );" ) ) )
                                {
                                    VenusShowError( $connection );
                                }
                                else
                                {
                                    if ( mysqli_num_rows( $paramValidationQuery ) != 2 )
                                    {
                                        $SQLDebug = "select *
                                            from {$tableParams}
                                            where Name = '{$cleanParamName}'
                                                and (
                                                    ValueName = '".DATA_ENTRY_MIN_INT_VALUE."'
                                                    or ValueName = '".DATA_ENTRY_MAX_INT_VALUE."' );";
                                        $errors[] = "Cannot find min or max validation for '{$cleanParamName}' in '{$readTables["GlobalsParams"]}'.";
                                    }
                                    else
                                    {
                                        $validationThresholds = array();
                                        while ( $rowResult = mysqli_fetch_array( $paramValidationQuery ) )
                                        {
                                            $validationThresholds[$rowResult["ValueName"]] = $rowResult["Value"];
                                        }
                                        $min =  intval( $validationThresholds[DATA_ENTRY_MIN_INT_VALUE] );
                                        $max =  intval( $validationThresholds[DATA_ENTRY_MAX_INT_VALUE] );
                                        $value = intval( $cleanParamValue );

                                        if ( ($value < $min) || ($value > $max) )
                                        {
                                            $errors[] = "Out of range for '{$cleanParamName}'. Number entered '{$value}'"
                                                . " should have been between '{$min} and '{$max}'.";
                                            return false;
                                        }
                                        else
                                        {
                                            // In range - validation OK
                                            $success = true;
                                        }
                                    }
                                    mysqli_free_result( $paramValidationQuery );
                                }
                            }
                            else if ( $paramNamesQueryResult["Flags"] & DATA_ENTRY_LENGTH )
                            {
                                if ( !($paramValidationQuery = @mysqli_query( $connection,
                                        "select *
                                        from {$tableParams}
                                        where Name = '{$cleanParamName}'
                                            and ValueName = '".DATA_ENTRY_MAX_LENGTH."';" ) ) )
                                {
                                    VenusShowError( $connection );
                                }
                                else
                                {
                                    if ( mysqli_num_rows( $paramValidationQuery ) != 1 )
                                    {
                                        $SQLDebug = "select *
                                            from {$tableParams}
                                            where Name = '{$cleanParamName}'
                                                and ValueName = '".DATA_ENTRY_MAX_LENGTH."';";
                                        $errors[] = "Cannot find max length validation for '{$cleanParamName}' in '{$tableParams}'.";
                                    }
                                    else
                                    {
                                        $validationThresholds = array();
                                        while ( $rowResult = mysqli_fetch_array( $paramValidationQuery ) )
                                        {
                                            $validationThresholds[$rowResult["ValueName"]] = $rowResult["Value"];
                                        }
                                        $maxLength =  intval( $validationThresholds[DATA_ENTRY_MAX_LENGTH] );
                                        $curLength = strlen( $cleanParamValue );
                                        
                                        if ( $curLength > $maxLength )
                                        {
                                            $errors[] = "Out of range for '{$cleanParamName}'. Number of characters entered '{$curLength}'"
                                                . " maximum is '{$maxLength}'.";
                                            return false;
                                        }
                                        else
                                        {
                                            // In range - validation OK
                                            $success = true;
                                        }
                                    }
                                }
                            }
                            else
                            {
                                // No other TEXT type of field validation specified, so assume data OK
                                $success = true;
                            }
                        }
                        else if ( $paramNamesQueryResult["DataEntryType"] == DATA_ENTRY_YESNO_RADIO )
                        {
                            if ( ( $cleanParamValue != DATA_ENTRY_YES ) &&
                                    ( $cleanParamValue != DATA_ENTRY_NO) )
                            {
                                $errors[] = "Expected Yes/No value for '{$cleanParamName}' got '{cleanParamValue}'.";
                            }
                            else
                            {
                                $success = true;
                            }
                        }
                        else  // For all other types of data entry validate as follows
                        {
                            if ( !($paramValuesQuery = @mysqli_query( $connection,
                                    "select *
                                    from {$tableParams}
                                    where Name = '{$cleanParamName}'
                                    and ValueName = '{$cleanParamValue}';" ) ) )
                            {
                                VenusShowError( $connection );
                            }

                            if ( mysqli_num_rows( $paramValuesQuery ) != 1 )
                            {
                                $errors[] = "Globalvalue '{$cleanParamValue}' for '{$cleanParamName}' cannot be found.";
                            }
                            else
                            {
                                // Since a field exists for this data assume OK to add data to field
                                $success = true;
                            }
                            mysqli_free_result( $paramValuesQuery );
                        }
                    }
                }
            }
        }
        else
        {
            $errors[] = "Global parameter '{$cleanParamName}' cannot be found, or is duplicated.";
        }
        mysqli_free_result( $paramNamesQuery );
    }

    return $success;
}

/******************************************************************************
** Function:    VenusGetTimeZoneFromDB
** Parameters:      connection [in] is the database handle
** Returns:         either the timezone code specified in the DB or UTC on error
**
** Retrieves the time zone setting stored in the database. The timezone
** is described in the Venus timezone format. A further lookup against
** LTM and LangLTM tables would be required to make the value
** understandable by the system user.
**
** NB: the value is stored in the update management table which was selected
**     because typically if there are any locked tables present then
**     update management is likely to be included as a locked table.
**     Remember if any tables are locked in a database then only locked
**     tables can be used in SQL queries.
*/
function VenusGetTimeZoneFromDB( $connection )
{
    $timeZone = 0;

    if ( $queryResult = @mysqli_query( $connection,
                "select Value from ".UPDATE_MGT_TABLE." where Name = '".UPDATEMGT_TZ."';" ) )
    {
        if ( ($db_timezone = mysqli_fetch_array( $queryResult )) != null )
        {
            $timeZone = intval( $db_timezone["Value"] );
        }
        mysqli_free_result( $queryResult );
    }
    else
    {
        VenusShowError( $connection );
    }

    return $timeZone;
}

?>
