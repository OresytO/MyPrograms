
    sql_str = "CREATE  TABLE `payment` ( ";
    sql_str += "  `payment_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str += "  `payment` TEXT(45) NULL); ";
    
    sql_str = "CREATE  TABLE `courier` ( ";
    sql_str += "  `name_storage_number` TEXT(30) NOT NULL , ";
    sql_str += "  `adress` TEXT(60) NOT NULL , ";
    sql_str += "  `phone_1` TEXT(15) NULL , ";
    sql_str += "  `phone_2` TEXT(15) NULL , ";
    sql_str += "  `phone_3` TEXT(15) NULL , ";
    sql_str += "  `passport_for_id` TEXT(60) NOT NULL , ";
    sql_str += "  `payment_id` Number NOT NULL) ;";
    
    sql_str = "CREATE  TABLE `forwarder` ( ";
    sql_str += "  `forwarder_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str += "  `name` TEXT(50) NOT NULL , ";
    sql_str += "  `code_¹_passport` TEXT(100) NOT NULL , ";
    sql_str += "  `code_¹_driver_lice` TEXT(45) NOT NULL , ";
    sql_str += "  `job_title` TEXT(60) NOT NULL , ";
    sql_str += "  `sign` TEXT(3) NOT NULL) ;";
    
    sql_str = "CREATE  TABLE `contragent` ( ";
    sql_str += "  `contragent_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str += "  `name` TEXT(45) NOT NULL , ";
    sql_str += "  `adress` TEXT(45) NOT NULL , ";
    sql_str += "  `phone_1` TEXT(45) NULL , ";
    sql_str += "  `phone_2` TEXT(45) NULL) ;";
    
    
    sql_str = "CREATE  TABLE `status` ( ";
    sql_str += "  `status_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str += "  `status` TEXT(45) NULL) ;";
    
    
    sql_str = "CREATE  TABLE `cities` ( ";
    sql_str += "  `cities_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str += "  `name` TEXT(45) NOT NULL , ";
    sql_str += "  `zip_code` TEXT(45) NULL ) ;";
    
    
    sql_str = "CREATE  TABLE `power_of_attorney` ( ";
    sql_str += "  `power_of_attorney_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str += "  `power_of_attorney_date` DATE NOT NULL , ";
    sql_str += "  `¹_power_of_attorney` TEXT(20) NOT NULL , ";
    sql_str += "  `sign_id` Number NOT NULL , ";
    sql_str += "  `forwarder_id` Number NOT NULL) ;";
    
    
    sql_str = "CREATE  TABLE `delivery` ( ";
    sql_str += "  `delivery_id` AUTOINCREMENT PRIMARY KEY , ";
    sql_str += "  `send_date` DATE NULL , ";
    sql_str += "  `take_date` DATE NULL , ";
    sql_str += "  `delivery_cost` DECIMAL(20,2) NULL , ";
    sql_str += "  `places` Number NULL , ";
    sql_str += "  `declaration_number` TEXT(20) NULL , ";
    sql_str += "  `contact_person` TEXT(30) NULL , ";
    sql_str += "  `note` TEXT(90) NULL , ";
    sql_str += "  `weight` DECIMAL(15,2) NULL , ";
    sql_str += "  `size` TEXT(30) NULL , ";
    sql_str += "  `taker_id` Number NOT NULL , ";
    sql_str += "  `sender_id` Number NOT NULL , ";
    sql_str += "  `status_id` Number NOT NULL , ";
    sql_str += "  `destionation_place_id` Number NOT NULL , ";
    sql_str += "  `sender_place_id` Number NOT NULL , ";
    sql_str += "  `power_of_attorney_id` Number NULL , ";
    sql_str += "  `in_or_out` TEXT(45) NOT NULL , ";
    sql_str += "  `courier_id` TEXT(30) NOT NULL ) ;";
    
    