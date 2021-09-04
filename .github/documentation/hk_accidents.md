# Dataset on accidents in Hong Kong between 2014 and 2019

## Description
A dataset containing traffic accidents between 2014 and 2019.

## Usage
```R
hk_accidents <- download_datasets("hk_accidents")
hk_accidents
```



## Format
A data frame with 95821 rows and 32 variables:

1. `Date_Time` - `dttm` object containing the date and time of the
   incident.
2. `OBJECTID` - Numeric. Identifier for the row.
3. `Year` - Numeric. Year in which incident has occurred.
4. `Serial_No_` - Numeric. Serial number for cross-matching with data
   between `hk_accidents`, `hk_casualties` and `hk_vehicles`.
5. `Severity` - String representing the severity of the incident. Values
   include: `Fatal`, `Serious`, `Slight`.
6. `District_Council_District` - String. Code representing district in
   which the incident has occurred. Join with `hkdistrict_summary` to extract
   full labels. District boundaries are accurate as of 2019.
7. `Hit_and_Run` - Logical. Indicates whether the incident is a
   hit-and-run.
8. `Weather` - String. Description of weather conditions.
9. `Rain` - String. Description of rain conditions.
10. `Natural_Light` - String. Description of lighting conditions.
11. `Junction_Control` - String. Description of junction condition.
12. `Vehicle_Movements` - String. Description of the number of moving
    vehicles.
13. `Type_of_Collision` - String. Description of type of collision.
14. `No_of_Vehicles_Involved` - Numeric. Number of vehicles involved in
    collision.
15. `No_of_Casualties_Injured` - Numeric. Number of casualties injured in
    collision.
16. `Grid_E` - Numeric. Eastings as per the 1980 Hong Kong Grid System.
17. `Grid_N` - Numeric. Northings as per the 1980 Hong Kong Grid System.
18. `latitude` - Numeric. Latitude values.
19. `longitude` - Numeric. Longitude values.
20. `Within_70m` - Logical.
21. `Precise_Location` - Character. Text description of the precise location.
22. `Accident` - Logical. Indicates whether incident was an accident.
23. `Junction_Type` - Character.
24. `Crossing_Control` - Character.
25. `Crossing_Type` - Character.
26. `Street_Name` - Character.
27. `Road_Type` - Character.
28. `Cycle_Type` - Character.
29. `Type_of_Collision_with_cycle` - Character.
30. `Structure_Type` - Character.
31. `Road_Hierarchy` - Character.
32. `Road_Ownership` - Character.

## Source
https://www.td.gov.hk/