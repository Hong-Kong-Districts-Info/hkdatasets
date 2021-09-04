# Dataset of vehicles involved in collisions between 2014 and 2019

## Description
 A dataset containing information of collisions by vehicles between 2014 and 2019.

## Usage
```R
hk_vehicles <- download_datasets("hk_vehicles")
hk_vehicles
```



## Format
A data frame with 153062 rows and 14 variables:

 1. `OBJECTID` - Numeric. Identifier for the row.
 2. `Serial_No_` - Numeric. Serial number for cross-matching with data between `hk_accidents`, `hk_casualties` and `hk_vehicles`.
 3. `Year` - Numeric. Year in which incident has occurred.
 4. `Vehicle_Class` - Character.
 5. `Vehicle_Collision` - Character.
 6. `First_point` - Character.
 7. `Severity_of_Accident` - Character. Indicates the severity of the accident. Can be 'Fatal', 'Serious', or 'Slight'.
 8. `Driver_Age` - Numeric. Indicates the age of the driver.
 9. `Driver_Sex` - Character. Indicates the sex of the driver.
 10. `Main_vehicle` - Character.
 11. `Year_of_Manufacture` - Character.
 12. `Grid_E` - Numeric. Eastings as per the 1980 Hong Kong Grid System.
 13. `Grid_N` - Numeric. Northings as per the 1980 Hong Kong Grid System.
 14. `Pedal_cycle` - Character.

## Source
https://www.td.gov.hk/