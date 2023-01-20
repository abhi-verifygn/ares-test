<?php
    /******************************************************************************
    **
    **  COMPONENT:          hol.helper.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Provides useful utities useful to the hol form and AJAX PHP processors
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    hol_checkDateTimes
    ** Parameters:      numHolidays [in] number of holidays to check
    **                  requestData [in] posted data from browser
    **                  errors [in/out] error information as an array of strings
    **                  validatedTimes [in/out] table of validated times
    ** Returns:         true if update occurred, false otherwise
    **
    ** Local helper function to confirm whether date and time entries are in
    ** a valid representation and b) if a special zero data 0-0 is the date
    ** for a holiday row, clears any times entered setting them to 00:00.
    */
    function hol_checkDateTimes( $holDayIDs, $requestData, &$errors, &$validatedTimes )
    {
        $success = true;

        $timeNames = array(
            "OpenTimeValue",
            "CloseTimeValue" );

        foreach( $holDayIDs as $dayID )
        {
            if ( !isset( $requestData[ $dayID ] ) )
            {
                $success = false;
                $errors[] = "Unable to find form data for holiday row {$dayID}.";
                continue;
            }

            // Check the date format 
            if ( !VenusValidateDate( $requestData[$dayID]["DayValue"], $errors, true ) )
            {
                $success = false;
                $errors[] = "Date format is incorrect for holiday row {$dayID}.";
                continue;
            }

            // Check for zero date special case
            $zeroDate = false;
            $day = 0; $month = 0;
            $converted = sscanf( $requestData[$dayID]["DayValue"], "%d-%d", $day, $month );
            if ( ( $converted == 2 ) && ( $day == 0 ) && ( $month == 0 )  )
            {
                $zeroDate = true;
            }

            
            // Make sure that we have valid times entered into the
            // form and obtain the timestamps of each entry.

            $discardedData = array();

            foreach ( $timeNames as $timeName )
            {
                if ( $zeroDate == true )
                {
                    // Special case replace any times provided with 00:00
                    $validatedTimes[$dayID][$timeName ] = "00:00";
                }
                else
                {
                    if ( !VenusValidateTime( $requestData[$dayID][$timeName], $discardedData[$timeName ], $errors ) )
                    {
                        $errors[] = "Invalid time for holiday row {$dayID} and {$timeName}";
                        $success = false;
                    }
                    else
                    {
                        $validatedTimes[$dayID][$timeName ] = $requestData[$dayID][$timeName];
                    }
                }
            }
        } // end_for $numHolidays
        return $success;
    }
?>
