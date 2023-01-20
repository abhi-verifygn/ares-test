<?php
    /******************************************************************************
    **
    **  COMPONENT:          tme.helper.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Provides useful utities useful to the the tme form and AJAX PHP processors
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    tme_checkTimes
    ** Parameters:      daysOfWeek [in] set of IDs representing days of week
    **                  requestData [in] posted data from browser
    **                  errors [in/out] error information as an array of strings
    ** Returns:         true if update occurred, false otherwise
    **
    ** Local helper function to confirm whether a) time entries are in
    ** a valid representation and b) whether the opening, day time start,
    ** night time start and closing times are in the correct ascending
    ** sequence.
    **
    */
    function tme_checkTimes( $daysOfWeek, $requestData, &$errors )
    {
        $success = true;

        $timeNames = array(
            "OpenTimeValue",
            "CloseTimeValue",
            "DayTimeValue",
            "NightTimeValue" );

        foreach( $daysOfWeek as $day )
        {
            if ( !isset( $requestData[ $day ] ) )
            {
                $success = false;
                $errors[] = "Unable to find form data for day {$day}.";
                continue;
            }

            $validatedTimes = array();

            // Make sure that we have valid times entered into the
            // form and obtain the timestamps of each entry.
            foreach ( $timeNames as $timeName )
            {
                if ( !VenusValidateTime( $requestData[$day][$timeName], $validatedTimes[$timeName ], $errors ) )
                {
                    $errors[] = "Invalid time for {$day} and {$timeName}";
                    $success = false;
                }
            }
        } // end_for $daysOfWeek
        return $success;
    }
?>
