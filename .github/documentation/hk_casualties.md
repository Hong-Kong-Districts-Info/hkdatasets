# Dataset of casualties involved in collisions between 2014 and 2019

## Description
A dataset containing information of collisions by casualties between 2014 and 2019.

## Usage
```R
hk_casualties <- download_datasets("hk_casualties")
hk_casualties
```



## Format
A data frame with 120,110 rows and 20 variables:

  1. `OBJECTID` - Numeric. Identifier for the row.
  2. `Year` - Numeric. Year in which incident has occurred.
  3. `Serial_No_` - Numeric. Serial number for cross-matching with data between `hk_accidents`, `hk_casualties` and `hk_vehicles`.
  4. `Casualty_Age` - Numeric.
  5. `Casualty_Sex` - Character.
  6. `Degree_of_Injury` - Character.
  7. `Role_of_Casualty` - Character.
  8. `Location_of_Injury_Head` - Logical.
  9. `Location_of_Injury_Upper_trunk` - Logical.
  10. `Location_of_Injury_Lower_trunk` - Logical.
  11. `Location_of_Injury_Arms` - Logical.
  12. `Location_of_Injury_Legs` - Logical.
  13. `Pedestrian_Action` - Character.
  14. `Vehicle_Class_of_Driver_or_Pass` - Character.
  15. `Ped_Action` - Character.
  16. `Ped_Location` - Character.
  17. `Ped_Circumstances` - Character.
  18. `Grid_E` - Numeric. Eastings as per the 1980 Hong Kong Grid System.
  19. `Grid_N` - Numeric. Northings as per the 1980 Hong Kong Grid System.
  20. `Pedal_cycle` - Character.

## Source
https://www.td.gov.hk/