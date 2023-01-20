#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.mvl.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the monitor volume settings form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    mvl_update
    ** Parameters:      connection [in] database handle
    **                  writeTables[in] array of table names locked for writing
    **                  readTables [in] array of table names locked for reading
    **                  requestData [in] data orginating from form
    **                  errors [in/out] error information as concatenated strings
    ** Returns:         true if update occurred, false otherwise
    **
    ** This function is called by the VenusPerformFormMultiTableUpdate helper function when
    ** requestData is ready to be written to the write locked table.
    **
    */
    function mvl_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
      if (!isset( $requestData["params"] ) )
      {
        $errors[] = "No monitor volume parameters have been specified. Nothing to do.";
        return false;
      }
      else
      {
        $successfulUpdates = 0;
        foreach( $requestData["params"] as $paramName => $paramAttributes )
        {
          $cleanParamName = VenusMySqlVarClean( $paramName, 25, $connection );
				
          if($cleanParamName != "DL2Mix")
          {
            // Ensure that the expected attributes are present
            if ( !isset($paramAttributes["volume"]) || !isset($paramAttributes["state"]) )
            {
              $errors[] = "Missing attributes for {$cleanParamName}";
              continue;
            }

            // Make sure that the data is clean and sane.
            $cleanVolume = VenusMySqlVarClean( $paramAttributes["volume"], 3, $connection );
            $cleanState = VenusMySqlVarClean( $paramAttributes["state"], 1, $connection );
          }
          else
          {
            // Ensure that the expected attributes are present
            if ( !isset($paramAttributes["state"]) )
            {
              $errors[] = "Missing attributes for {$cleanParamName}";
              continue;
            }

            // Make sure that the data is clean and sane.
            $cleanVolume = 0;
            $cleanState = VenusMySqlVarClean( $paramAttributes["state"], 1, $connection );
          }

          // Check the contents of the attributes are valid

          // Checking value in range
          if ( !($paramValidationQuery = @mysqli_query( $connection,
                                                        "select MinValue, MaxValue
                                                         from {$writeTables["MonitorVolume"]}
                                                         where Type = '{$cleanParamName}';" ) ) )
          {
            VenusShowError( $connection );
          }
          else
          {
            if ( mysqli_num_rows( $paramValidationQuery ) != 1 )
            {
              $errors[] = "Cannot find min or max validation for '{$cleanParamName}'.";
            }
            else
            {
              if ( ($minMaxResult = mysqli_fetch_array( $paramValidationQuery ) ) == null )
              {
                $errors[] = "Cannot retrieve the min or max validation for '{$cleanParamName}'.";
                continue;
              }

              $min =  intval( $minMaxResult["MinValue"] );
              $max =  intval( $minMaxResult["MaxValue"] );
              $value = intval( $cleanVolume );

              if ( strcmp( strval($value), $cleanVolume ) != 0 )
              {
                $errors[] = "Possible corrupt number entry for {$cleanParamName} . Is '{$cleanVolume}' a number?";
                continue;
              }

              if ( ($value < $min) || ($value > $max) )
              {
                $errors[] = "Attribute {$cleanParamName} - out of range error for '{$cleanVolume}'. Number entered '{$value}'"
                             . " should have been between '{$min} and '{$max}'.";
                continue;
              }
            }

            mysqli_free_result( $paramValidationQuery );
          }

          // Checking state in range
          if ( ($cleanState != 0 ) && ($cleanState != 1 ) )
          {
            $errors[] = "Unrecognised state for {$cleanParamName}";
            continue;
          }

          // Update the database
          if ( !mysqli_query( $connection,
               "UPDATE {$writeTables["MonitorVolume"]}
               SET Volume='{$cleanVolume}',
               State='{$cleanState}'
               WHERE Type='{$cleanParamName}';" ) )
          {
            VenusShowError( $connection );
          }
          else
          {
            ++$successfulUpdates;
          }
        }

        /* Lane 2 updates */
        $successfulUpdatesL2 = 0;

        foreach( $requestData["paramsL2"] as $paramName => $paramAttributes )
        {
          $cleanParamName = VenusMySqlVarClean( $paramName, 25, $connection );

          if($cleanParamName != "DL2Mix")
          {
            // Ensure that the expected attributes are present
            if ( !isset($paramAttributes["volume"]) || !isset($paramAttributes["state"]) )
            {
              $errors[] = "Missing attributes for {$cleanParamName}";
              continue;
            }

            // Make sure that the data is clean and sane.
            $cleanVolume = VenusMySqlVarClean( $paramAttributes["volume"], 3, $connection );
            $cleanState = VenusMySqlVarClean( $paramAttributes["state"], 1, $connection );

            // Check the contents of the attributes are valid

            // Checking value in range
            if ( !($paramValidationQuery = @mysqli_query( $connection,
                                                          "select MinValue, MaxValue
                                                           from {$writeTables["DL2MonitorVolume"]}
                                                           where Type = '{$cleanParamName}';" ) ) )
            {
              VenusShowError( $connection );
            }
            else
            {
              if ( mysqli_num_rows( $paramValidationQuery ) != 1 )
              {
                $errors[] = "Cannot find min or max validation for '{$cleanParamName}'.";
              }
              else
              {
                if ( ($minMaxResult = mysqli_fetch_array( $paramValidationQuery ) ) == null )
                {
                  $errors[] = "Cannot retrieve the min or max validation for '{$cleanParamName}'.";
                  continue;
                }

                $min =  intval( $minMaxResult["MinValue"] );
                $max =  intval( $minMaxResult["MaxValue"] );
                $value = intval( $cleanVolume );

                if ( strcmp( strval($value), $cleanVolume ) != 0 )
                {
                  $errors[] = "Possible corrupt number entry for {$cleanParamName} . Is '{$cleanVolume}' a number?";
                  continue;
                }

                if ( ($value < $min) || ($value > $max) )
                {
                  $errors[] = "Attribute {$cleanParamName} - out of range error for '{$cleanVolume}'. Number entered '{$value}'"
                               . " should have been between '{$min} and '{$max}'.";
                  continue;
                }
              }

              mysqli_free_result( $paramValidationQuery );
            }

            // Checking state in range
            if ( ($cleanState != 0 ) && ($cleanState != 1 ) )
            {
              $errors[] = "Unrecognised state for {$cleanParamName}";
              continue;
            }

            // Update the database
            if ( !mysqli_query( $connection,
                                "UPDATE {$writeTables["DL2MonitorVolume"]}
                                 SET Volume='{$cleanVolume}',
                                 State='{$cleanState}'
                                 WHERE Type='{$cleanParamName}';" ) )
            {
              VenusShowError( $connection );
            }
            else
            {
              ++$successfulUpdatesL2;
            }
          }
          else
          {
            ++$successfulUpdatesL2;
          }
        }

        return ($successfulUpdates == count($requestData["params"])) && ($successfulUpdates == $successfulUpdatesL2);
      }
    }

    /******************************************************************************
    **  Script entry point
    **
    */
    if ( session_start() == false )
    {
        exit;
    }

    if ( VenusSessionAuthenticate() == false )
    {
        exit;
    }

    $_SESSION[ SESS_ERROR ] = "";
    $_SESSION[ SESS_MESSAGE ] = "";

    if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) )
    {
        $warnings = array();
        $writeTables = array( "MonitorVolume"=>"MonitorVolume",
                              "DL2MonitorVolume"=>"DL2MonitorVolume" );
        $readTables = array( "LangMonitorVolume"=>"LangMonitorVolume" );


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "mvl", "mvl_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }

        header(
            "Location: {$_SERVER["HTTP_REFERER"]}",
            true, // replace any existing location header
            303   // HTTP "303 see other" response code
            );
        exit;
    }
    else
    {
         // Authenticated user, but trying to directly access a form processor
        $_SESSION[SESS_MESSAGE] = "You are not allowed to access this resource directly.";
        header(
            "location: logout.php",
            true, // replace any existing location header
            303   // HTTP "303 see other" response code
            );
        exit;
    }
?>
